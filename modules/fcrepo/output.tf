output "URL" {
  value = "${aws_route53_record.fedora.fqdn}/rest"
}

output "SecurityGroup" {
  value = "aws_security_group.fedora.id"
}
