output "EnvironmentName" {
  value = "${aws_elastic_beanstalk_environment.webapp.name}"
}

output "URL" {
  value = "http://${aws_route53_record.webapp.fqdn}"
}

output "SecurityGroup" {
  value = "${aws_security_group.webapp.id}"
}

output "SecurityGroupLB" {
  value = "${aws_security_group.webapp_lb.id}"
}
