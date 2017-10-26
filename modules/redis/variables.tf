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

variable InstanceType {
  type        = "string"
  description = "The cache instance type"
  default     = "cache.m1.small"
}

variable StackName {
  type        = "string"
  description = "Name of the environment"
}

variable WebappSecurityGroup {
  type        = "string"
  description = "Security group to be granted redis access"
}

## Temp until vpc done.
variable vpc_id {
  type    = "string"
  default = "vpc-d84467b3"
}
