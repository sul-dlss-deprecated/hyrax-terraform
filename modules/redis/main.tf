# Create a security group allowing a webapp access to the redis port.
resource "aws_security_group" "redis" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.security_group_name}"

  ingress {
    security_groups = ["${var.access_security_groups}"]
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
  }

  tags {
    Name = "${var.security_group_name}"
  }
}

# Create the actual redis
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.replication_group}"
  replication_group_description = "Hyrax redis cluster using ElastiCache"

  node_type             = "${var.instance_class}"
  number_cache_clusters = 1
  port                  = 6379

  subnet_group_name  = "${var.subnet_group_name}"
  security_group_ids = ["${aws_security_group.redis.id}"]
}
