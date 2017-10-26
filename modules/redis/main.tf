resource "aws_elasticache_replication_group" "redis" {
  node_type                     = "${var.InstanceType}"
  subnet_group_name             = "${aws_elasticache_subnet_group.redis_subnet_group.id}"
  security_group_ids            = ["${aws_security_group.redis_security_group.id}"]
  number_cache_clusters         = "${var.NumCacheNodes}"

  # Not in the cloudformation config, but required by Terraform.
  replication_group_id          = "hyku-redis-cluster"
  replication_group_description = "Hyku redis stack using ElastiCache"
  port                          = 6379
}
