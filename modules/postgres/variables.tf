# Removing - setting directly as part of module, leaving commented out until
#  migration complete to make it clear that this is something we are
#  deliberately removing.
#variable SecurityGroups {
#  type        = "commadelimitedlist"
#  description = "A list of security group ids, such as sg-a123fd85"
#}

variable SubnetID {
  type        = "string"
  description = "List of an existing subnet IDs to use for the load balancer and auto scaling group"
}

variable DatabaseName {
  type        = "string"
  description = "Name of the database"
  default     = "hybox"
}

variable MasterUsername {
  type        = "string"
  description = "Database Root Username"
  default     = "ebroot"
}

variable MasterUserPassword {
  type        = "string"
  description = "Password for the DB Root User"
}

variable DBInstanceClass {
  type        = "string"
  description = "Instance size"
  default     = "db.t2.medium"
}

variable AllocatedStorage {
  type        = "string"
  description = "Size of DB in Gigs"
  default     = "5"
}

variable MultiAZDatabase {
  type        = "string"
  description = "Launch the database in multiple availability zones"
  default     = "true"
}

variable SecurityGroupName {
  type        = "string"
  description = "Name of the security group created"
  default     = "RDS security group"
}

variable AccessSecurityGroup {
  type        = "string"
  description = "Security group to give access to this database"
  default     = ""
}

variable StackName {
  type        = "string"
  description = "Name of the environment"
}

## Temp until vpc done.
variable vpc_id {
  type    = "string"
  default = "vpc-d84467b3"
}
