module "hyrax_vpc" {
  source = "./modules/vpc"

  private_hosted_zone_name = "${var.private_hosted_zone_name}"
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

module "hyrax_application" {
  source = "./modules/application"

  application_name = "${aws_elastic_beanstalk_application.hyrax.name}"
  version_label    = "${aws_elastic_beanstalk_application_version.webapp.name}"

  vpc_id                  = "${module.hyrax_vpc.vpc_id}"
  public_subnets          = "${module.hyrax_vpc.public_subnets}"
  private_subnets         = "${module.hyrax_vpc.private_subnets}"
  db_subnet_group_name    = "${module.hyrax_vpc.database_subnet_group}"
  cache_subnet_group_name = "${module.hyrax_vpc.elasticache_subnet_group}"

  key_name                 = "${var.key_name}"
  hosted_zone_name         = "${var.public_hosted_zone_name}"
  instance_security_groups = ["${aws_security_group.webapp.id}"]
  lb_security_groups       = ["${aws_security_group.webapp_lb.id}"]
  db_password              = "${var.webapp_db_password}"
  rails_secret_key         = "${var.rails_secret_key}"
  fcrepo_url               = "${module.hyrax_fedora.url}"
  solr_url                 = "${module.hyrax_solrcloud.solr_url}"
  ssl_certificate_id       = "${var.ssl_certificate_id}"
  honeybadger_key          = "${var.hydrox_honeybadger_key}"
  honeybadger_env          = "development"
}
