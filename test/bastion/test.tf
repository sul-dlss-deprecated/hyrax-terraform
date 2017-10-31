# Simple test of the bastion module, seeing if the result is what we expect.
resource "aws_security_group" "test" {
  vpc_id = "vpc-d84467b3"
}

resource "aws_key_pair" "bastion_test" {
  key_name   = "bastion-test-key"
  public_key = "${file("ssh/bastion.test.pub")}"
}

module bastion {
  source = "../../modules/bastion"

  vpc_id         = "vpc-d84467b3"
  region         = "${var.region}"
  StackName      = "Testing Bastion"
  SubnetID       = ["subnet-de4467b5"]
  SecurityGroups = ["${aws_security_group.test.id}"]
  KeyName        = "${aws_key_pair.bastion_test.key_name}"
  InstanceType   = "t2.nano"
}
