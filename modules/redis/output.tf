output "redis_endpoint" {
  value = "${aws_elasticache_replication_group.redis.primary_endpoint_address}"
}

output "redis_port" {
  value = "6379"
}
