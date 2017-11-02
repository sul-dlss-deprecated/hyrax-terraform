output "zookeeper_exhibitor" {
  description = "The URL for the exhibitor UI"
  value       = "http://${aws_route53_record.zookeeper.fqdn}/exhibitor/v1/ui/index.html"
}

output "zookeeper_endpoint" {
  description = "The URL for connecting straight to zookeeper"
  value       = "${aws_route53_record.zookeeper.fqdn}:2181"
}

output "zookeeper_hosts" {
  description = "The DNS record for zookeeper ips"
  value       = "zk-ips.${aws_route53_record.zookeeper.name}"
}
