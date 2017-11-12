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
  source = "./modules/bastion"

  vpc_id          = "${module.hyrax_vpc.vpc_id}"
  subnets         = ["${module.hyrax_vpc.public_subnets}"]
  security_groups = ["${aws_security_group.bastion.id}"]
  key_name        = "${var.key_name}"
}

module "hyrax_solrcloud" {
  source = "./modules/solrcloud"

  vpc_id   = "${module.hyrax_vpc.vpc_id}"
  subnets  = ["${module.hyrax_vpc.private_subnets}"]
  key_name = "${var.key_name}"

  application_name = "${aws_elastic_beanstalk_application.hyrax.name}"
  hosted_zone_name = "${module.hyrax_vpc.private_hosted_zone_name}"
  hosted_zone_id   = "${module.hyrax_vpc.private_hosted_zone_id}"

  zookeeper_environment_cname          = "hyrax-zookeeper-demo"
  zookeeper_version_label              = "${aws_elastic_beanstalk_application_version.zookeeper.name}"
  zookeeper_lb_security_groups         = ["${aws_security_group.zookeeper_lb.id}"]
  zookeeper_instance_security_groups   = ["${aws_security_group.zookeeper.id}"]
  zookeeper_shared_configs_bucket_name = "zookeeper-shared-configs"

  solr_environment_cname        = "hyrax-solr-demo"
  solr_version_label            = "${aws_elastic_beanstalk_application_version.solr.name}"
  solr_lb_security_groups       = ["${aws_security_group.solr_lb.id}"]
  solr_instance_security_groups = ["${aws_security_group.solr.id}","${aws_security_group.solr_to_lb.id}"]
}

module "hyrax_fedora" {
  source = "./modules/fcrepo"

  application_name  = "${aws_elastic_beanstalk_application.hyrax.name}"
  environment_cname = "hyrax-fedora-demo"

  vpc_id  = "${module.hyrax_vpc.vpc_id}"
  subnets = "${module.hyrax_vpc.private_subnets}"
  db_subnet_group_name = "${module.hyrax_vpc.database_subnet_group}"

  key_name                 = "${var.key_name}"
  version_label            = "${aws_elastic_beanstalk_application_version.fedora.name}"
  hosted_zone_name         = "${module.hyrax_vpc.private_hosted_zone_name}"
  hosted_zone_id           = "${module.hyrax_vpc.private_hosted_zone_id}"
  instance_security_groups = ["${aws_security_group.fedora.id}"]
  lb_security_groups       = ["${aws_security_group.fedora_lb.id}"]
  db_password              = "${var.fcrepo_db_password}"
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

module "hyrax_fedora" {
  source = "modules/fcrepo"

  application_name  = "${aws_elastic_beanstalk_application.hyrax.name}"
  environment_name  = "fedora"
  environment_cname = "hyrax-fedora-demo"

  vpc_id                 = "${module.hyrax_vpc.vpc_id}"
  SubnetID               = "${module.hyrax_vpc.private_subnets}"

  KeyName                = "${var.KeyName}"
  version_label          = "${aws_elastic_beanstalk_application_version.fedora.name}"
  SecurityGroups         = ["${aws_security_group.default.id}","${aws_security_group.fedora.id}"]
  WebappSecurityGroup    = "${aws_security_group.webapp.id}"
  LBSecurityGroups       = ["${aws_security_group.fedora_lb.id}"]
  MinSize                = "${var.FcrepoMinSize}"
  MaxSize                = "${var.FcrepoMaxSize}"
  HostedZoneName         = "${var.public_hosted_zone_name}"
  InstanceType           = "${var.FcrepoInstanceType}"
  RDSHostname            = "${module.hyrax_fcrepodb.EndpointAddress}"
  RDSPort                = "${module.hyrax_fcrepodb.EndpointPort}"
  RDSUsername            = "${var.FcrepoDatabaseUsername}"
  RDSPassword            = "${var.FcrepoDatabasePassword}"
  StackName              = "${var.StackName}-fcrepo"
}
