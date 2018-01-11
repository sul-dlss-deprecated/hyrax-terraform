variable "application_name" {
  description = ""
}

variable "environment_cname" {
  default = "hyrax-webapp-demo"
}

variable "version_label" {
  description = ""
}

variable "vpc_id" {
  description = "VPC identifier"
}

variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
}

variable "application_upload_bucket_name" {
  description = "Bucket name for the application upload endpoint"
  default = "hyrax-application-upload"
}

variable "public_subnets" {
  description = ""
  type = "list"
}

variable "private_subnets" {
  description = ""
  type = "list"
}

variable "hosted_zone_name" {
  description = ""
}

variable "cache_subnet_group_name" {
  description = "Cache subnet group name from VPC module"
}

variable "db_subnet_group_name" {
  description = "DB subnet group name from VPC module"
}

variable "db_name" {
  description = "Name for application db"
  default = "hyrax"
}

variable "db_password" {
  description = "Password for application db"
}

variable "instance_security_groups" {
  description = ""
  type = "list"
}

variable "lb_security_groups" {
  description = ""
  type = "list"
}

variable "efs_security_groups" {
  description = ""
  type = "list"
}

variable "rails_secret_key" {
  description = ""
}

variable "fcrepo_url" {
  description = ""
}

variable "solr_url" {
  description = ""
}

variable "ssl_certificate_id" {
  description = ""
}

variable "honeybadger_key" {
  description = ""
}

variable "honeybadger_env" {
  description = "The api key for honeybadger.io"
}

variable "suri_url" {
  description = "The url for suri"
}

variable "suri_username" {
  description = ""
}

variable "suri_password" {
  description = ""
}

variable "efs_mount_path" {
  description = ""
}
