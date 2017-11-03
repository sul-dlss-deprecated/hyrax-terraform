data "aws_region" "current" {
  current = true
}

data "aws_route53_zone" "selected" {
  name = "${var.hosted_zone_name}."
}

data "aws_caller_identity" "current" {}
