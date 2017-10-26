variable SecurityGroups {
  type        = "commadelimitedlist"
  description = "A list of security group ids, such as sg-a123fd85"
}

variable SubnetID {
  type        = "list"
  description = "List of an existing subnet IDs to use for the load balancer and auto"
}

variable InstanceType {
  type        = "string"
  description = "The cache instance type"
}

