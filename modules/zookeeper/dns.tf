data "aws_route53_zone" "selected" {
  name = "${var.hosted_zone_name}."
  private_zone = true
}

resource "aws_route53_record" "zookeeper" {
  name = "zookeeper.${data.aws_route53_zone.selected.name}"

  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  type    = "CNAME"
  ttl     = "900"
  records = ["${aws_elastic_beanstalk_environment.zookeeper.cname}"]
}
