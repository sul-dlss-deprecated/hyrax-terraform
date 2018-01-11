# Create these security groups at top level to avoid dependancy loops.
resource "aws_security_group" "default" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-default"

  ingress {
    security_groups = ["${aws_security_group.bastion.id}"]
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
  }

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-default"
  }
}

resource "aws_security_group" "bastion" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-bastion"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-bastion"
  }
}

resource "aws_security_group" "webapp" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-webapp"

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-webapp"
  }
}

resource "aws_security_group" "webapp_lb" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-webapp-lb"

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-webapp-lb"
  }
}

resource "aws_security_group" "webapp_efs" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-webapp-efs"

  ingress {
    security_groups = ["${aws_security_group.webapp.id}"]
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
  }

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-webapp-efs"
  }
}

resource "aws_security_group" "fedora" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-fedora"

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-fedora"
  }
}

resource "aws_security_group" "fedora_lb" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-fedora-lb"

  ingress {
    security_groups = ["${aws_security_group.webapp.id}"]
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
  }

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-fedora-lb"
  }
}

resource "aws_security_group" "solr" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-solr"

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
    Name = "${module.hyrax_vpc.vpc_id}-solr"
  }
}

resource "aws_security_group" "solr_lb" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-solr_lb"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.webapp.id}"]
  }

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-solr_lb"
  }
}

resource "aws_security_group" "solr_to_lb" {
  vpc_id = "${module.hyrax_vpc.vpc_id}"
  name   = "${module.hyrax_vpc.vpc_id}-solr_to_lb"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.solr.id}"]
  }

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-solr_to_lb"
  }
}

resource "aws_security_group" "zookeeper_lb" {
  name   = "${module.hyrax_vpc.vpc_id}-zookeeper_lb"
  vpc_id = "${module.hyrax_vpc.vpc_id}"

  ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
    security_groups = ["${aws_security_group.solr.id}","${aws_security_group.webapp.id}"]
  }

  tags {
    Name = "${module.hyrax_vpc.vpc_id}-zookeeper_lb"
  }
}

resource "aws_security_group" "zookeeper" {
  name   = "${module.hyrax_vpc.vpc_id}-zookeeper"
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
    Name = "${module.hyrax_vpc.vpc_id}-zookeeper"
  }
}
