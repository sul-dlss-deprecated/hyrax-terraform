resource "aws_autoscaling_group" "bastion" {
  vpc_zone_identifier  = ["${var.SubnetID}"]
  launch_configuration = "${aws_launch_configuration.bastion.name}"
  min_size             = "1"
  max_size             = "2"
  desired_capacity     = "1"

  tag {
    key                 = "name"
    value               = "${var.StackName}"
    propagate_at_launch = "true"
  }
}

# TODO: I'm not at all sure how to translate these to terraform.  The only
#       example I found uses an argument that no longer exists.
#
# CreationPolicy:
#   ResourceSignal:
#     Timeout: PT25M
# UpdatePolicy:
#   AutoScalingRollingUpdate:
#     MinInstancesInService: '2'
#     MaxBatchSize: '1'
#     PauseTime: PT5M
#     WaitOnResourceSignals: 'true'

resource "aws_launch_configuration" "bastion" {
  name            = "bastion_config"
  image_id        = "${lookup(var.AWSRegionToAMI, var.region)}"
  instance_type   = "${var.InstanceType}"
  security_groups = ["${var.SecurityGroups}"]
  key_name        = "${var.KeyName}"
}
