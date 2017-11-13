module "appdb" {
  source = "../postgres"

  vpc_id            = "${var.vpc_id}"
  subnet_group_name = "${var.db_subnet_group_name}"

  name                   = "${var.db_name}"
  password               = "${var.db_password}"
  security_group_name    = "${var.application_name}-postgres-app"
  access_security_groups = "${var.instance_security_groups}"
}
