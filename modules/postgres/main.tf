# Create a security group allowing access to the database port.
resource "aws_security_group" "postgresql" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.security_group_name}"

  ingress {
    security_groups = ["${var.access_security_groups}"]
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
  }

  tags {
    Name = "${var.security_group_name}-${var.name}"
  }
}

# Create the RDS instance itself.
resource "aws_db_instance" "postgresql" {
  name     = "${var.name}"
  engine   = "postgres"
  username = "${var.username}"
  password = "${var.password}"

  instance_class            = "${var.instance_class}"
  db_subnet_group_name      = "${var.subnet_group_name}"
  vpc_security_group_ids    = ["${aws_security_group.postgresql.id}"]
  allocated_storage         = "${var.allocated_storage}"
  multi_az                  = "${var.multi_az}"
  final_snapshot_identifier = "final-fcrepo"
}
