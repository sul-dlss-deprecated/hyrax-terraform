variable "application_name" {
  description = ""
}

variable "environment_name" {
  description = ""
}

variable "version_label" {
  description = ""
}

variable "vpc_id" {
  description = "VPC to create the resources in"
}

variable "subnets" {
  description = "List of an existing subnet IDs to use for the auto scaling group"
  type        = "list"
}

variable "security_groups" {
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

variable "sqs_queue_name" {
  description = "SQS Default Queue"
}

variable "honeybadger_key" {
  description = "The api key for honeybadger.io"
}

variable "honeybadger_env" {
  description = "The api key for honeybadger.io"
}

variable "efs_filesystem" {
  description = ""
}

variable "efs_mount_path" {
  description = ""
}
