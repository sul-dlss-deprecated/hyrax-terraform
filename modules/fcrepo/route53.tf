resource "aws_route53_record" "fedora" {
  name    = "fcrepo.${var.hosted_zone_name}"
  zone_id = "${var.hosted_zone_id}"
  type    = "CNAME"
  ttl     = "900"
  records = [
    "${aws_elastic_beanstalk_environment.fedora.cname}"
  ]
}
