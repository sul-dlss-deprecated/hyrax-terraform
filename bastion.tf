module "bastion" {
  source = "modules/bastion"

  vpc_id         = "${module.hyrax_vpc.vpc_id}"
  region         = "${var.region}"
  StackName      = "${var.StackName}"
  SubnetID       = "${module.hyrax_vpc.public_subnets}"
  SecurityGroups = "${aws_security_group.bastion.id}"
  KeyName        = "${var.KeyName}"
  InstanceType   = "${var.BastionInstanceType}"
}
