resource "aws_route53_record" "hyrax_mail" {
  name = "${var.application_domain}."

  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  type    = "MX"
  ttl     = "6000"
  records = ["10 inbound-smtp.${data.aws_region.current.name}.amazonaws.com"]
}
