variable StackName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable ApplicationName {
  type        = "string"
  description = "Name of the Zookeeper environment"
}

variable KeyName {
  type        = "aws::ec2::keypair::keyname"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the EB instances"
}

variable MinSize {
  type        = "number"
  description = "Minimum number of instances"
}

variable MaxSize {
  type        = "number"
  description = "Maximum number of instances"
}

variable InstanceType {
  type        = "string"
  description = "The EC2 instance type"
}

variable HealthReportingSystemType {
  type        = "string"
  description = "Health reporting system"
}

variable S3Bucket {
  type        = "string"
  description = "Bucket with ZK source bundle"
}

variable S3Key {
  type        = "string"
  description = "Key for ZK source bundle"
}

variable SubnetID {
  type        = "list"
  description = "List of an existing subnet IDs to use for the load balancer and auto"
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

