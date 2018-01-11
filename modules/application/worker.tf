module "worker" {
  source = "../worker"

  application_name  = "${var.application_name}"
  environment_name  = "worker"
  version_label     = "${var.version_label}"

  vpc_id  = "${var.vpc_id}"
  subnets = "${var.private_subnets}"

  key_name                 = "${var.key_name}"
  security_groups          = "${var.instance_security_groups}"
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
  sqs_queue_name           = "${aws_sqs_queue.default.id}"
  honeybadger_key          = "${var.honeybadger_key}"
  honeybadger_env          = "${var.honeybadger_env}"
  efs_filesystem           = "${aws_efs_file_system.hyrax.id}"
  efs_mount_path           = "${var.efs_mount_path}"
}
