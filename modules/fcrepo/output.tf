output "URL" {
  value = "${aws_route53_record.fedora.fqdn}/rest"
}
