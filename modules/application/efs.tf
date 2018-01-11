resource "aws_efs_file_system" "hyrax" {
  creation_token = "hyrax-derivatives"
}

resource "aws_efs_mount_target" "derivatives" {
  count = "${length(var.private_subnets)}"

  file_system_id  = "${aws_efs_file_system.hyrax.id}"
  security_groups = "${var.efs_security_group}"
  subnet_id       = "${element(var.private_subnets, count.index)}"
}
