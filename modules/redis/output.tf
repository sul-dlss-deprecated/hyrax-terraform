output "EndpointAddress" {
  value = "${aws_elasticache_replication_group.redis.primary_endpoint_address}"
}

# Always this value for redis, no query that gives this.
output "EndpointPort" {
  value = "6379"
}
