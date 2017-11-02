resource "aws_security_group" "zookeeper_lb" {
  name = "${var.environment_cname}-lb"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    security_groups = ["${var.lb_security_groups}"]
  }

  tags {
    Name = "zookeeper lb security group"
    Terraform = "true"
  }
}

resource "aws_security_group" "zookeeper_ssh" {
  name = "${var.environment_cname}-ssh"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_cidr_blocks}"]
  }

  tags {
    Name = "zookeeper ssh security group"
    Terraform = "true"
  }
}



resource "aws_security_group" "zookeeper_instance_lb" {
  name = "${var.environment_cname}-2181-instance-lb"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    security_groups = ["${aws_security_group.zookeeper_lb.id}"]
  }

  ingress {
    from_port   = 8181
    to_port     = 8181
    protocol    = "tcp"
    security_groups = ["${aws_security_group.zookeeper_lb.id}"]
  }

  tags {
    Name = "zookeeper 2181 instance from lb security group"
    Terraform = "true"
  }
}

# resource "aws_security_group" "zookeeper_8181_instance_lb" {
#   name = "${var.environment_cname}-8181-instance-lb"
#   vpc_id = "${var.vpc_id}"
#
#   ingress {
#     from_port   = 8181
#     to_port     = 8181
#     protocol    = "tcp"
#     security_groups = ["${aws_security_group.zookeeper_lb.id}"]
#   }
#
#   tags {
#     Name = "zookeeper 8181 instance from lb security group"
#     Terraform = "true"
#   }
# }

resource "aws_security_group" "zookeeper_instance" {
  name = "${var.environment_cname}-instance"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    security_groups = ["${var.instance_security_groups}"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }

  tags {
    Name = "zookeeper instance security group"
    Terraform = "true"
  }
}

# resource "aws_security_group_rule" "allow_all_within_sg" {
#   type        = "ingress"
#   from_port   = 0
#   to_port     = 65535
#   protocol    = "tcp"
#
#   security_group_id = "${aws_security_group.zookeeper_ssh.id}"
#   source_security_group_id = "${aws_security_group.zookeeper_ssh.id}"
# }

resource "aws_security_group" "lambda_egress" {
  name = "${var.environment_cname}-lambda"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "lambda egress security group"
    Terraform = "true"
  }
}
