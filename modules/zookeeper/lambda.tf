data "archive_file" "upsert_zip" {
  type        = "zip"
  source_dir  = "assets/lambdas/zookeeper_upsert"
  output_path = "assets/lambdas/upsert.zip"
}

resource "aws_lambda_permission" "zookeeper_lambda_invoke" {
  statement_id  = "zookeeper-lambda-invoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.zookeeper_lambda_route53_upsert.function_name}"
  principal     = "events.amazonaws.com"
}

resource "aws_lambda_function" "zookeeper_lambda_route53_upsert" {
  function_name    = "zookeeper-lambda-route53-upsert"
  filename         = "assets/lambdas/upsert.zip"
  source_code_hash = "${data.archive_file.upsert_zip.output_base64sha256}"

  role    = "${aws_iam_role.iam_for_zookeeper_lambda.arn}"
  handler = "upsert.handler"
  runtime = "nodejs4.3"
  timeout = "10"

  vpc_config {
    subnet_ids         = ["${split(",", var.subnets)}"]
    security_group_ids = ["${aws_security_group.lambda_egress.id}"]
  }

  environment {
    variables = {
      RecordSetName = "zk-ips.${aws_route53_record.zookeeper.name}"
      HostedZoneId  = "${aws_route53_record.zookeeper.zone_id}"
    }
  }
}

resource "aws_cloudformation_stack" "zookeeper_invoke_on_create" {
  name = "zookeeper-invoke-on-create"

  timeout_in_minutes = "6"

  parameters {
    LambdaArn        = "${aws_lambda_function.zookeeper_lambda_route53_upsert.arn}"
    ZookeeperASGName = "${aws_elastic_beanstalk_environment.zookeeper.autoscaling_groups[0]}"
  }

  template_body = <<STACK
{
  "Parameters" : {
    "LambdaArn" : {
      "Type" : "String",
      "Description" : "The arn for the lambda function"
    },
    "ZookeeperASGName" : {
      "Type" : "String",
      "Description" : "The ASG name for zookeeper environment"
    }
  },
  "Resources" : {
    "ZookeeperInvokeOnCreate": {
      "Type" : "Custom::ZookeeperInvokeOnCreate",
      "Properties" : {
        "ServiceToken" : { "Ref" : "LambdaArn" },
        "ZookeeperASGName" : { "Ref" : "ZookeeperASGName" }
      }
    }
  }
}
STACK
}
