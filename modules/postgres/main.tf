# Create a security group allowing access to the database port.
resource "aws_security_group" "postgresql" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.SecurityGroupName}"

  ingress {
    security_groups = ["${var.AccessSecurityGroup}"]
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
  }

  tags {
    Name      = "${var.StackName}-${var.DatabaseName}db-sg"
    Terraform = "true"
  }
}

# Create the RDS instance itself.
resource "aws_db_instance" "postgresql" {
  name                   = "${var.DatabaseName}"
  engine                 = "postgres"
  username               = "${var.MasterUsername}"
  password               = "${var.MasterUserPassword}"
  instance_class         = "${var.DBInstanceClass}"
  db_subnet_group_name   = "${var.SubnetID}"
  vpc_security_group_ids = ["${aws_security_group.postgresql.id}"]
  allocated_storage      = "${var.AllocatedStorage}"
  multi_az               = "${var.MultiAZDatabase}"

  tags {
    Name      = "${var.StackName}-${var.DatabaseName}db"
    Terraform = "true"
  }
}
