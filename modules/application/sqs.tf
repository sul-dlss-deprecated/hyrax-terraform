# Create queues for default messages, and to move dead messages to after a
# 5m delay.
resource "aws_sqs_queue" "default" {
  name                       = "default_queue"
  visibility_timeout_seconds = "3600"
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dead_letter.arn}\",\"maxReceiveCount\":5}"
}

resource "aws_sqs_queue" "dead_letter" {
  name = "dead_letter_queue"
}
