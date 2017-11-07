data "aws_iam_policy_document" "slack_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "slack_integration" {
  statement {
    sid = "1"
    actions = [
      "logs:createLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
    actions = [
      "cloudformation:DescribeStacks",
      "elasticbeanstalk:Describe*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "slack_integration" {
  name   = "slack"
  path   = "/"
  policy = "${data.aws_iam_policy_document.slack_integration.json}"
}

# Add the IAM role to set access for what the integration can do.
resource "aws_iam_role" "slack_integration" {
  name               = "slack"
  assume_role_policy = "${data.aws_iam_policy_document.slack_assume_role.json}"
}
