resource "aws_cloudwatch_event_target" "zookeeper_upsert" {
  target_id = "zookeeper-upsert"
  rule      = "${aws_cloudwatch_event_rule.zookeeper.name}"
  arn       = "${aws_lambda_function.zookeeper_lambda_route53_upsert.arn}"
}

resource "aws_cloudwatch_event_rule" "zookeeper" {
  name = "zookeeper-ec2-tracking"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance Launch Successful",
    "EC2 Instance Terminate Successful"
  ],
  "detail": {
    "AutoScalingGroupName": [
      "${aws_elastic_beanstalk_environment.zookeeper.autoscaling_groups[0]}"
    ]
  }
}
PATTERN
}
