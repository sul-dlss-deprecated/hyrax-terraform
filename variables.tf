variable "profile" {
  description = "AWS credentials profile"
  default = "default"
}

variable "region" {
  description = "AWS region to run resources in"
  default = "us-east-1"
}

variable "private_hosted_zone_name" {
  description = "Name for private hosted zone for private services"
  default = "hyrax-private.sul.stanford.edu"
}

variable "public_hosted_zone_name" {
  description = "Existing Route53 zone; used to create a public DNS record for the application load balancer"
  default     = "sul.stanford.edu"
}

variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to instances"
  default     = "hybox"
}

variable "fcrepo_db_password" {
  default = "changeme"
}

variable "webapp_db_password" {
  default = "changeme"
}

variable "rails_secret_key" {
  description = ""
}

variable "ssl_certificate_id" {
  description = ""
}

variable "hydrox_honeybadger_key" {
  description = ""
}
