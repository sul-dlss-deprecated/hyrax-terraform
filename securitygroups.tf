# Create these security groups at top level to avoid dependancy loops.
resource "aws_security_group" "default" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "Default security group"

  ingress {
    security_groups = ["${aws_security_group.bastion.id}"]
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
  }

  tags {
    Name = "${var.StackName}-default"
  }
}

resource "aws_security_group" "bastion" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "Bastion security group"

  tags {
    Name = "${var.StackName}-bastion"
  }
}

resource "aws_security_group" "webapp" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "Webapp security group"

  tags {
    Name = "${var.StackName}-webapp"
  }
}

resource "aws_security_group" "fedora" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "Fedora security group"

  tags {
    Name = "${var.StackName}-fcrepo"
  }
}
