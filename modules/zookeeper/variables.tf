variable "application_name" {
  description = "Name for beanstalk application"
}

variable "environment_name" {
  description = "Name for beanstalk environment"
}

variable "environment_cname" {
  description = "CNAME for beanstalk environment"
}

variable "vpc_id" {
  description = "VPC id to deploy instances in"
}

variable "subnets" {
  description = "Subnets to deploy instances in"
}

variable "key_name" {
  description = "Name of SSH key pair"
}

variable "version_label" {
  description = "Version label from beanstalk_application_version module"
}

variable "instance_type" {
  description = "Instance type to deploy"
  default = "t2.micro"
}

variable "lb_security_groups" {
  description = "List of security groups to grant access to loadbalancer port 2181. This will be from solr and the webapp"
  default = []
  type = "list"
}

variable "instance_security_groups" {
  description = "List of security groups to grant access to instance port 2181. This will be from solr"
  default = []
  type = "list"
}

variable "hosted_zone_name" {
  description = "Route53 zone name within which to create a zookeeper record"
}

variable "shared_configs_bucket_name" {
  description = "Name for the S3 bucket to be created that zookeeper uses to share configuration"
}
