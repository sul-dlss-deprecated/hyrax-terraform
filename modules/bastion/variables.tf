variable "vpc_id" {
  description = "VPC id that provides the subnets"
}

variable "subnets" {
  description = "List of an existing subnet IDs for instance"
  type = "list"
}

variable "security_groups" {
  description = "A list of security groups, such as sg-a123fd85."
  type = "list"
}

variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to instances"
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.nano"
}
