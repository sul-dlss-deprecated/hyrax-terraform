resource "aws_iam_role" "iam_for_zookeeper_lambda" {
  name = "iam-for-zookeeper-lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_access_logs" {
  name = "lambda-access-logs"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_access_cfn_eb" {
  name = "lambda-access-cfn-eb"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudformation:DescribeStacks",
        "elasticbeanstalk:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_access_route53" {
  name = "lambda-access-route53"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "route53:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "managed_eb_enhaced_health" {
  role       = "${aws_iam_role.iam_for_zookeeper_lambda.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_role_policy_attachment" "managed_lambda_vpc_access_execution_role" {
  role       = "${aws_iam_role.iam_for_zookeeper_lambda.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_access_logs" {
  role       = "${aws_iam_role.iam_for_zookeeper_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_access_logs.arn}"
}

resource "aws_iam_role_policy_attachment" "lambda_access_cfn_eb" {
  role       = "${aws_iam_role.iam_for_zookeeper_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_access_cfn_eb.arn}"
}

resource "aws_iam_role_policy_attachment" "lambda_access_route53" {
  role       = "${aws_iam_role.iam_for_zookeeper_lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_access_route53.arn}"
}
