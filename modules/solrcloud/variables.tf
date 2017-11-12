variable "application_name" {}

variable "vpc_id" {}

variable "subnets" {
  description = ""
  type = "list"
}

variable "key_name" {}

variable "hosted_zone_name" {}

variable "hosted_zone_id" {}

variable "zookeeper_environment_cname" {}

variable "zookeeper_version_label" {}

variable "zookeeper_lb_security_groups" {
  description = ""
  type = "list"
}

variable "zookeeper_instance_security_groups" {
  description = ""
  type = "list"
}

variable "zookeeper_shared_configs_bucket_name" {}

variable "solr_environment_cname" {}

variable "solr_version_label" {}

variable "solr_lb_security_groups" {
  description = ""
  type = "list"
}

variable "solr_instance_security_groups" {
  description = ""
  type = "list"
}
