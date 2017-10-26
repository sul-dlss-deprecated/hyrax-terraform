variable StackName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable KeyName {
  type        = "aws::ec2::keypair::keyname"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
}

variable SubnetID {
  type        = "list"
  description = "List of an existing subnet IDs to use for the load balancer and auto"
}

variable S3Bucket {
  type        = "string"
  description = "S3 bucket with the Fcrepo war"
}

variable S3Key {
  type        = "string"
  description = "S3 key to the Fcrepo war"
}

variable MinSize {
  type        = "number"
  description = "Minimum number of instances"
}

variable MaxSize {
  type        = "number"
  description = "Maximum number of instances"
}

variable SecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85"
}

variable LBSecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85"
}

variable HostedZoneName {
  type        = "string"
  description = "Route53 zone to create an alias in"
}

variable InstanceType {
  type        = "string"
  description = "The EC2 instance type"
}

variable RDSUsername {
  type        = "string"
  description = "Username for Database"
}

variable RDSPassword {
  type        = "string"
  description = "Password for Database"
}

  noecho      = "'true'"
variable RDSHostname {
  type        = "string"
  description = "Hostname for RDS Database"
}

variable RDSPort {
  type        = "string"
  description = "Database Port"
}

variable HomePath {
  type        = "string"
  description = "Fedora home directory path"
}

variable BinaryStoreS3AccessKey {
  type        = "string"
  description = "Access Key Id providing access to binary store S3 bucket"
}

variable BinaryStoreS3SecretKey {
  type        = "string"
  description = "Secret Access Key providing access to binary store S3 bucket"
}

  noecho      = "'true'"
variable BinaryStoreS3Bucket {
  type        = "string"
  description = "Binary store S3 bucket"
}

