# IAM role creation and archive file creation are in their own files, as
# each are longer and more focused code.

# Create the SNS topic for our use.
resource "aws_sns_topic" "slack" {
  name = "sns-slack"
}

# Set the slack integration code.
resource "aws_lambda_function" "slack_integration" {
  function_name    = "slack_integration"
  description      = "Posts SNS messages to a Slack channel"
  filename         = "slack.zip"
  source_code_hash = "${data.archive_file.slack.output_base64sha256}"
  role             = "${aws_iam_role.slack_integration.arn}"
  handler          = "index.handler"
  runtime          = "nodejs4.3"
}

# Allow the SNS topic the permission to run our slack integration.
resource "aws_lambda_permission" "slack_integration" {
  statement_id  = "AllowSlackfromSNS"
  function_name = "${aws_lambda_function.slack_integration.function_name}"
  action        = "lambda:InvokeFunction"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.slack.arn}"
}

# Subscribe the SNS topic to our integration.
resource "aws_sns_topic_subscription" "slack_integration" {
  topic_arn = "${aws_sns_topic.slack.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.slack_integration.arn}"
}
