# Removing - setting directly as part of module, leaving commented out until
#  migration complete to make it clear that this is something we are
#  deliberately removing.
#variable SecurityGroups {
#  type        = "commadelimitedlist"
#  description = "A list of security group ids, such as sg-a123fd85"
#}

variable "vpc_id" {
  description = "VPC id to deploy database in"
}

variable "subnet_group_name" {
  description = "Name of an existing databse subnet group"
}

variable "name" {
  description = "Name of the database"
}

variable "username" {
  description = "Database Root Username"
  default     = "root"
}

variable "password" {
  description = "Password for the DB Root User"
}

variable "instance_class" {
  description = "Instance size"
  default     = "db.t2.medium"
}

variable "allocated_storage" {
  description = "Size of database storage in GBs"
  default     = 5
}

variable "multi_az" {
  description = "Launch the database in multiple availability zones"
  default     = true
}

variable "security_group_name" {
  description = "Name of the security group to create"
}

variable "access_security_groups" {
  description = "Security groups to give access to this database"
  default = []
  type = "list"
}
