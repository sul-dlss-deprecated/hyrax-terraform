variable vpc_id {
  type        = "string"
  description = "VPC to create the resources in"
}

variable SecurityGroups {
  type        = "list"
  description = "Security groups to access fedora"
}

variable WebappSecurityGroup {
  type        = "string"
  description = "Web application security group id"
}

variable StackName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable KeyName {
  type        = "string"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
  default     = "hybox"
}

variable SubnetID {
  type        = "string"
  description = "List of an existing subnet IDs to use for the load balancer and auto"
}

variable S3Bucket {
  type        = "string"
  description = "S3 bucket with the Fcrepo war"
  default     = "hybox-deployment-artifacts"
}

variable S3Key {
  type        = "string"
  description = "S3 key to the Fcrepo war"
}

variable MinSize {
  type        = "string"
  description = "Minimum number of instances"
  default     = "1"
}

variable MaxSize {
  type        = "string"
  description = "Maximum number of instances"
  default     = "2"
}

variable HostedZoneName {
  type        = "string"
  description = "Route53 zone to create an alias in"
  default     = "hydrainabox.org"
}

variable InstanceType {
  type        = "string"
  description = "The EC2 instance type"
  default     = "t2.large"
}

variable RDSUsername {
  type        = "string"
  description = "Username for Database"
  default     = "ebroot"
}

variable RDSPassword {
  type        = "string"
  description = "Password for Database"
}

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
  default     = "/var/lib/fcrepo"
}

variable BinaryStoreS3AccessKey {
  type        = "string"
  description = "Access Key Id providing access to binary store S3 bucket"
}

variable BinaryStoreS3SecretKey {
  type        = "string"
  description = "Secret Access Key providing access to binary store S3 bucket"
}

variable BinaryStoreS3Bucket {
  type        = "string"
  description = "Binary store S3 bucket"
}
