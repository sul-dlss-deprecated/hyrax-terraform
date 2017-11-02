resource "aws_security_group" "solr_ssh" {
  name = "${var.environment_cname}-ssh"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_cidr_blocks}"]
  }

  tags {
    Name = "solr ssh security group"
    Terraform = "true"
  }
}

resource "aws_security_group" "solr_lb" {
  name = "${var.environment_cname}-lb"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${var.lb_security_groups}"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.solr_ssh.id}"]
  }

  tags {
    Name = "solr lb security group"
    Terraform = "true"
  }
}

resource "aws_security_group" "solr_instance" {
  name = "${var.environment_cname}-instance"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 8983
    to_port     = 8983
    protocol    = "tcp"
    security_groups = ["${aws_security_group.solr_lb.id}"]
  }

  tags {
    Name = "solr instance security group"
    Terraform = "true"
  }
}

resource "aws_security_group_rule" "allow_all_within_sg" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"

  security_group_id = "${aws_security_group.solr_instance.id}"
  source_security_group_id = "${aws_security_group.solr_instance.id}"
}
