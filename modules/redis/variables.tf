variable "vpc_id" {
  description = "VPC ID to deploy redis in"
}

variable "subnet_group_name" {
  description = "Name of an existing cache subnet group"
}

variable "security_group_name" {
  description = "Name of the security group to create"
}

variable "access_security_groups" {
  description = "Security groups to give access to this database"
  default = []
  type = "list"
}

variable "replication_group" {
  description = "Name of the redis cluster to create"
  default     = "hyrax-redis-cluster"
}

variable "instance_class" {
  description = "Instance size"
  default     = "cache.m1.small"
}
