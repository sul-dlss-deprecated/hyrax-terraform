variable "application_name" {
  description = ""
}

variable "environment_name" {
  description = ""
  default = "fedora"
}

variable "environment_cname" {
  description = ""
}

variable "version_label" {
  description = ""
}

variable "vpc_id" {
  description = "VPC to create the resources in"
}

variable "subnets" {
  description = "Comma separated list of an existing subnet IDs to use for the load balancer and instances"
  type = "list"
}

variable "hosted_zone_name" {
  description = "Route53 zone to create an alias in"
}

variable "hosted_zone_id" {
  description = "Route53 zone id to create an alias in"
}

variable "lb_security_groups" {
  type        = "list"
  description = "Security groups to access fedora LB"
  default = []
}

variable "instance_security_groups" {
  type        = "list"
  description = "Security groups to access fedora instances"
  default = []
}

variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to instances"
}

variable "fedora_bucket_name" {
  description = "Binary store S3 bucket"
  default = "hyrax-fedora-binaries"
}

variable "min_size" {
  description = "Minimum number of instances"
  default = 1
}

variable "max_size" {
  description = "Maximum number of instances"
  default = 1
}

variable "instance_type" {
  description = "The EC2 instance type"
  default = "t2.large"
}

variable "db_name" {
  description = "Name for fedora database"
  default = "fcrepo"
}

variable "db_password" {
  description = "Password for fedora database"
}

variable "db_subnet_group_name" {
  description = "Database subnet group name from VPC module"
}
