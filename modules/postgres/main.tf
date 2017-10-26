resource "aws_db_instance" "postgresql" {
  name                   = "${var.DatabaseName}"
  engine                 = "postgres"
  username               = "${var.MasterUsername}"
  password               = "${var.MasterUserPassword}"
  instance_class         = "${var.DBInstanceClass}"
  db_subnet_group_name   = "${var.DBSubnetGroup}
  vpc_security_group_ids = "${var.SecurityGroups}"
  allocated_storage      = "${var.AllocatedStorage}"
  multi_az               = "${var.MultiAZDatabase}"
}
