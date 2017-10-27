output "BeanstalkSNSTopic" {
  value = "${aws_sns_topic.slack.arn}"
}
