module "hyrax_zookeeper" {
  source = "../zookeeper"

  application_name  = "${var.application_name}"
  environment_name  = "zookeeper"
  environment_cname = "${var.zookeeper_environment_cname}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.subnets}"

  key_name                   = "${var.key_name}"
  version_label              = "${var.zookeeper_version_label}"
  lb_security_groups         = ["${var.zookeeper_lb_security_groups}"]
  instance_security_groups   = ["${var.zookeeper_instance_security_groups}"]
  hosted_zone_name           = "${var.hosted_zone_name}"
  hosted_zone_id             = "${var.hosted_zone_id}"
  shared_configs_bucket_name = "${var.zookeeper_shared_configs_bucket_name}"
}

module "hyrax_solr" {
  source = "../solr"

  application_name  = "${var.application_name}"
  environment_name  = "solr"
  environment_cname = "${var.solr_environment_cname}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.subnets}"

  key_name                 = "${var.key_name}"
  version_label            = "${var.solr_version_label}"
  lb_security_groups       = ["${var.solr_lb_security_groups}"]
  instance_security_groups = ["${var.solr_instance_security_groups}"]
  hosted_zone_name         = "${var.hosted_zone_name}"
  hosted_zone_id           = "${var.hosted_zone_id}"
  zookeeper_hosts          = "${module.hyrax_zookeeper.zookeeper_hosts}"
}
