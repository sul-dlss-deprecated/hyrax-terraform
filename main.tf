module "hyrax_vpc" {
  source = "./modules/vpc"

  private_hosted_zone_name = "${var.private_hosted_zone_name}"
}

module "hyrax_mail" {
  source = "./modules/mail"

  hosted_zone_name   = "${var.public_hosted_zone_name}"
  application_domain = "hyrax.${var.public_hosted_zone_name}"
  mail_bucket_name   = "hyrax-mail"
}

module "hyrax_bastion" {
  source = "modules/bastion"

  vpc_id         = "${module.hyrax_vpc.vpc_id}"
  region         = "${var.region}"
  StackName      = "${var.StackName}"
  SubnetID       = ["${module.hyrax_vpc.public_subnets}"]
  SecurityGroups = ["${aws_security_group.bastion.id}"]
  KeyName        = "${var.KeyName}"
  InstanceType   = "${var.BastionInstanceType}"
}

module "hyrax_database" {
  source = "modules/postgres"

  StackName           = "${var.StackName}"
  SubnetID            = "${module.hyrax_vpc.database_subnet_group}"
  vpc_id              = "${module.hyrax_vpc.vpc_id}"

  DatabaseName        = "${var.DatabaseName}"
  MasterUsername      = "${var.DatabaseUsername}"
  MasterUserPassword  = "${var.DatabasePassword}"
  DBInstanceClass     = "${var.DatabaseInstanceType}"
  AllocatedStorage    = "${var.DatabaseStorageSize}"
  MultiAZDatabase     = "${var.DatabaseMultiAZ}"
  SecurityGroupName   = "RDS security group"
  AccessSecurityGroup = "${aws_security_group.webapp.id}"
}

module "hyrax_fcrepodb" {
  source = "modules/postgres"

  StackName           = "${var.StackName}"
  SubnetID            = "${module.hyrax_vpc.database_subnet_group}"
  vpc_id              = "${module.hyrax_vpc.vpc_id}"

  DatabaseName        = "${var.FcrepoDatabaseName}"
  MasterUsername      = "${var.FcrepoDatabaseUsername}"
  MasterUserPassword  = "${var.FcrepoDatabasePassword}"
  DBInstanceClass     = "${var.FcrepoDatabaseInstanceType}"
  AllocatedStorage    = "${var.FcrepoDatabaseStorageSize}"
  MultiAZDatabase     = "${var.FcrepoDatabaseMultiAZ}"
  SecurityGroupName   = "Fedora RDS security group"
  AccessSecurityGroup = "${aws_security_group.fedora.id}"
}

module "hyrax_redis" {
  source = "modules/redis"

  StackName           = "${var.StackName}"
  SubnetID            = "${module.hyrax_vpc.elasticache_subnet_group}"
  WebappSecurityGroup = "${aws_security_group.webapp.id}"
  InstanceType        = "${var.RedisInstanceType}"
  vpc_id              = "${module.hyrax_vpc.vpc_id}"
}

# TODO: Enable this once the rest of testing is done, for further debugging.
#module "hyrax_slack" {
#  source = "modules/slack"
#
#  SlackWebhookToken   = "${var.SlackWebhookToken}"
#  SlackWebhookChannel = "${var.SlackWebhookChannel}"
#}
