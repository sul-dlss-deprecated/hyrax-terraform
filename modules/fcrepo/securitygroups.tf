# Security groups for the Fedora stack.
resource "aws_security_group" "fedora_lb" {
  vpc_id = "${var.vpc_id}"
  name   = "Fedora load balancer security group"

  ingress {
    security_groups = ["${var.WebappSecurityGroup}"]
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
  }

  tags {
    Name = "${var.StackName}-fcrepo-lb"
  }
}
