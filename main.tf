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
  SecurityGroups = ["${list(aws_security_group.bastion.id)}"]
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

module "hyrax_zookeeper" {
  source = "modules/zookeeper"

  application_name  = "${aws_elastic_beanstalk_application.hyrax.name}"
  environment_name  = "zookeeper"
  environment_cname = "hyrax-zookeeper-demo"

  vpc_id  = "${module.hyrax_vpc.vpc_id}"
  subnets = "${module.hyrax_vpc.private_subnets}"

  key_name                   = "${var.KeyName}"
  version_label              = "${aws_elastic_beanstalk_application_version.zookeeper.name}"
  lb_security_groups         = ["${aws_security_group.zookeeper_lb.id}"]
  instance_security_groups   = ["${aws_security_group.zookeeper.id}"]
  hosted_zone_name           = "${var.private_hosted_zone_name}"
  shared_configs_bucket_name = "zookeeper-shared-configs"
}

module "hyrax_solr" {
  source = "modules/solr"

  application_name  = "${aws_elastic_beanstalk_application.hyrax.name}"
  environment_name  = "solr"
  environment_cname = "hyrax-solr-demo"

  vpc_id  = "${module.hyrax_vpc.vpc_id}"
  subnets = "${module.hyrax_vpc.private_subnets}"

  key_name                 = "${var.KeyName}"
  version_label            = "${aws_elastic_beanstalk_application_version.solr.name}"
  lb_security_groups       = ["${aws_security_group.solr_lb.id}"]
  instance_security_groups = ["${aws_security_group.solr.id}","${aws_security_group.solr_to_lb.id}"]
  hosted_zone_name         = "${var.private_hosted_zone_name}"
  zookeeper_hosts          = "${module.hyrax_zookeeper.zookeeper_hosts}"
}
