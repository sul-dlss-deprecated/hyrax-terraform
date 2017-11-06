output "solr_endpoint" {
  description = "The URL for SolrCloud"
  value       = "http://${aws_route53_record.solr.fqdn}/solr/"
}
