data "aws_route53_zone" "selected" {
  name = "${var.hosted_zone_name}."
}

resource "aws_route53_record" "webapp" {
  name    = "${var.ssl_domain_name}.${var.hosted_zone_name}"
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  type    = "CNAME"
  ttl     = "900"
  records = [
    "${aws_elastic_beanstalk_environment.webapp.cname}"
  ]
}
