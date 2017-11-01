# Get existing zone information.
data "aws_route53_zone" "webapp" {
  name = "${var.HostedZoneName}"
}

# Zone information
resource "aws_route53_record" "webapp" {
  name    = "${var.StackName}.${var.HostedZoneName}"
  zone_id = "${data.aws_route53_zone.fedora.zone_id}"
  type    = "A"

  alias {
    name    = "${aws_elastic_beanstalk_environment.webapp.cname"}
    zone_id = "${lookup($var.AWSRegionToBeanstalkHostedZoneId, $var.region)}"
  }
}

resource "aws_route53_record" "webapp_wildcard" {
  name    = "*.${var.StackName}.${var.HostedZoneName}"
  zone_id = "${data.aws_route53_zone.fedora.zone_id}"
  type    = "A"

  alias {
    name    = "${aws_elastic_beanstalk_environment.webapp.cname"}
    zone_id = "${lookup($var.AWSRegionToBeanstalkHostedZoneId, $var.region)}"
  }
}
