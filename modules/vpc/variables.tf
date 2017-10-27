variable "vpc_name" {
  description = "Name for VPC"
  default = "hyrax"
}

variable "enable_nat_gateway" {
  description = "Boolean on if to have a NAT Gateway for private subnets"
  default = "true"
}

variable "single_nat_gateway" {
  description = "Boolean on if to have a single NAT Gateway or one for each subnet"
  default = "true"
}

variable "enable_s3_endpoint" {
  description = "Boolean on if to enable private access to S3 from within VPC"
  default = true
}

variable "create_private_hosted_zone" {
  description = "Boolean on if to create a private hosted zone for private services"
  default = true
}

variable "private_hosted_zone_name" {
  description = "Name for private hosted zone for private services"
  default = ""
}
