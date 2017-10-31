# Get existing zone information.
data "aws_route53_zone" "fedora" {
  name = "${var.HostedZoneName}"
}

# Zone information
resource "aws_route53_record" "fedora" {
  name    = "fcrepo.${data.aws_route53_zone.fedora.zone_id}"
  zone_id = "${data.aws_route53_zone.fedora.zone_id}"
  type    = "CNAME"
  ttl     = "900"
  records = [
    "${aws_elastic_beanstalk_environment.fedora.cname}"
  ]
}
