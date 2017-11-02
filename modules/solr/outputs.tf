output "solr_endpoint" {
  description = "The URL for SolrCloud"
  value       = "http://${aws_route53_record.solr.fqdn}/solr/"
}

output "solr_security_groups" {
  description = "The security groups for granting solr access to resources"
  value       = ["${aws_security_group.solr_ssh.id}"]
}
