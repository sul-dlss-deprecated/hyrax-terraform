module "appcache" {
  source = "../redis"

  vpc_id            = "${var.vpc_id}"
  subnet_group_name = "${var.cache_subnet_group_name}"

  security_group_name    = "${var.application_name}-redis-app"
  access_security_groups = "${var.instance_security_groups}"
}
