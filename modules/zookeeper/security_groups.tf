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
