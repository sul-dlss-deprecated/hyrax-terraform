variable "application_name" {
  description = ""
}

variable "environment_name" {
  description = ""
}

variable "environment_cname" {
  description = ""
}

variable "version_label" {
  description = ""
}

variable "vpc_id" {
  description = "VPC to create the resources in"
}

variable "public_subnets" {
  description = "List of an existing subnet IDs to use for the load balancer"
  type        = "list"
}

variable "private_subnets" {
  description = "List of an existing subnet IDs to use for the auto scaling group"
  type        = "list"
}

variable "hosted_zone_name" {
  description = "Route53 zone to create an alias in"
}

variable "lb_security_groups" {
  type        = "list"
  description = "Security groups to access fedora LB"
  default = []
}

variable "instance_security_groups" {
  type        = "list"
  description = "Security groups to access fedora instances"
  default = []
}

variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to instances"
}

variable "min_size" {
  description = "Minimum number of instances"
  default = 1
}

variable "max_size" {
  description = "Maximum number of instances"
  default = 4
}

variable "instance_type" {
  description = "The EC2 instance type"
  default = "t2.small"
}

variable "rails_secret_key" {
  description = "Secret key for Rails"
}

variable "fcrepo_url" {
  description = "URL to Fedora"
}

variable "solr_url" {
  description = "URL to Solr"
}

variable "redis_host" {
  description = "URL to Redis"
}

variable "redis_port" {
  description = "Redis Port"
}

variable "db_name" {
  description = "Database name"
}

variable "db_username" {
  description = "Username for Database"
}

variable "db_password" {
  description = "Password for Database"
}

variable "db_hostname" {
  description = "Hostname for RDS Database"
}

variable "db_port" {
  description = "Database Port"
}

variable "iam_instance_profile" {
  description = "ARN for an IAM profile to assign to the EC2 instances"
}

# variable "queue_prefix" {
#   description = "SQS Queue prefix"
# }

# variable "default_queue" {
#   description = "SQS Default Queue"
# }

# variable "upload_bucket" {
#   description = "S3 Bucket to store uploaded files into"
# }

# variable "beanstalk_sns_topic" {
#   description = "SNS Topic for Beanstalk application to write change events to"
# }

variable "ssl_certificate_id" {
  description = "The Amazon Resource Name (ARN) of the SSL certificate"
}

variable "ssl_domain_name" {
  description = ""
  default = "hydrox-dev"
}

variable "honeybadger_key" {
  description = "The api key for honeybadger.io"
}

variable "honeybadger_env" {
  description = "The api key for honeybadger.io"
}

variable "suri_url" {
  description = "The url for suri"
}

variable "suri_username" {
  description = ""
}

variable "suri_password" {
  description = ""
}
