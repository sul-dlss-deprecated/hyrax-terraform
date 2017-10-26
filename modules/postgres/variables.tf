variable SubnetID {
  type        = "list"
  description = "List of an existing subnet IDs to use for the load balancer and auto scaling group"
}

variable DatabaseName {
  type        = "string"
  description = "Name of the database"
}

variable MasterUsername {
  type        = "string"
  description = "Database Root Username"
}

variable DBInstanceClass {
  type        = "string"
  description = "Instance size"
}

variable MasterUserPassword {
  type        = "string"
  description = "Password for the DB Root User"
}

variable SecurityGroups {
  type        = "commadelimitedlist"
  description = "A list of security group ids, such as sg-a123fd85"
}

variable AllocatedStorage {
  type        = "string"
  description = "Size of DB in Gigs"
}

variable MultiAZDatabase {
  type        = "string"
  description = "Launch the database in multiple availability zones"
}
