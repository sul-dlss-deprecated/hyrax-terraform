output "EnvironmentName" {
  value = "${aws_elastic_beanstalk_environment.webapp.name}"
}

output "URL" {
  value = "http://${aws_route53_record.webapp.fqdn}"
}
