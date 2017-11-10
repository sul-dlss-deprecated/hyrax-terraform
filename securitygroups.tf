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

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

resource "aws_security_group" "solr" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "Solr security group"

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  ingress {
    from_port       = 8983
    to_port         = 8983
    protocol        = "tcp"
    security_groups = ["${aws_security_group.solr_lb.id}"]
  }

  tags {
    Name = "${var.StackName}-solr"
  }
}

resource "aws_security_group" "solr_lb" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "Solr LB security group"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.webapp.id}"]
  }

  tags {
    Name = "${var.StackName}-solr-lb"
  }
}

resource "aws_security_group" "solr_to_lb" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "Solr instance to LB security group"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.solr.id}"]
  }

  tags {
    Name = "${var.StackName}-solr-to-lb"
  }
}

resource "aws_security_group" "zookeeper_lb" {
  name   = "Zookeeper LB security group"
  vpc_id = "${module.hyrax_vpc.vpc_id}"

  ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
    security_groups = ["${aws_security_group.solr.id}","${aws_security_group.webapp.id}"]
  }

  tags {
    Name = "${var.StackName}-zookeeper-lb"
  }
}

resource "aws_security_group" "zookeeper" {
  name   = "Zookeeper security group"
  vpc_id = "${module.hyrax_vpc.vpc_id}"

  ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
    security_groups = ["${aws_security_group.zookeeper_lb.id}","${aws_security_group.solr.id}"]
  }

  ingress {
    from_port       = 8181
    to_port         = 8181
    protocol        = "tcp"
    security_groups = ["${aws_security_group.zookeeper_lb.id}"]
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  tags {
    Name = "${var.StackName}-zookeeper"
  }
}
