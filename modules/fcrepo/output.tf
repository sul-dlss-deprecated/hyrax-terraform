output "url" {
  value = "http://${aws_route53_record.fedora.fqdn}/rest"
}
