module "webapp" {
  source = "../webapp"

  application_name  = "${var.application_name}"
  environment_name  = "webapp"
  environment_cname = "${var.environment_cname}"
  version_label     = "${var.version_label}"

  vpc_id          = "${var.vpc_id}"
  public_subnets  = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"

  hosted_zone_name = "${var.hosted_zone_name}"

  key_name                 = "${var.key_name}"
  instance_security_groups = "${var.instance_security_groups}"
  lb_security_groups       = "${var.lb_security_groups}"
  rails_secret_key         = "${var.rails_secret_key}"
  fcrepo_url               = "${var.fcrepo_url}"
  solr_url                 = "${var.solr_url}"
  redis_host               = "${module.appcache.redis_endpoint}"
  redis_port               = "${module.appcache.redis_port}"
  db_name                  = "${module.appdb.name}"
  db_username              = "${module.appdb.username}"
  db_password              = "${var.db_password}"
  db_hostname              = "${module.appdb.address}"
  db_port                  = "${module.appdb.port}"
  iam_instance_profile     = "${aws_iam_instance_profile.application.name}"
  ssl_certificate_id       = "${var.ssl_certificate_id}"
  honeybadger_key          = "${var.honeybadger_key}"
  honeybadger_env          = "${var.honeybadger_env}"
}
