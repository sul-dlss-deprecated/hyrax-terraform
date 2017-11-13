# Create a security group allowing a webapp access to the redis port.
resource "aws_security_group" "redis" {
  vpc_id = "${var.vpc_id}"
  name   = "Redis security group"

  ingress {
    security_groups = ["${var.WebappSecurityGroup}"]
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
  }

  tags {
    Name      = "${var.StackName}-redis-sg"
    Terraform = "true"
  }
}

# Create the actual redis
resource "aws_elasticache_replication_group" "redis" {
  node_type                     = "${var.InstanceType}"
  subnet_group_name             = "${var.SubnetID}"
  security_group_ids            = ["${aws_security_group.redis.id}"]
  number_cache_clusters         = "1"

  # Not in the cloudformation config, but required by Terraform.
  replication_group_id          = "hyku-redis-cluster"
  replication_group_description = "Hyku redis stack using ElastiCache"
  port                          = "6379"

  tags {
    Name      = "${var.StackName}-redis-sg"
    Terraform = "true"
  }
}
