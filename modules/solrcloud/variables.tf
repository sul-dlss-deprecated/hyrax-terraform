variable StackName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable S3Bucket {
  type        = "string"
  description = "S3 bucket to the cfn deployment artifacts"
}

variable S3KeyPrefix {
  type        = "string"
  description = "S3 prefix to deployment artifacts"
}

variable KeyName {
  type        = "aws::ec2::keypair::keyname"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
}

variable SubnetID {
  type        = "list"
  description = "List of an existing subnet IDs to use for the auto scaling group"
}

variable HostedZoneName {
  type        = "string"
  description = "Route53 zone to create an alias in"
}

variable HostedZoneID {
  type        = "string"
  description = "Route53 zone to create an alias in"
}

variable ZookeeperEnsembleSize {
  type        = "number"
  description = "Desired number of instances"
}

variable ZookeeperEnsembleMaxSize {
  type        = "number"
  description = "Maximum number zk of instances"
}

variable ZookeeperSecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85."
}

variable ZookeeperLBSecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85."
}

variable ZookeeperHealthReportingSystemType {
  type        = "string"
  description = "Health reporting system"
}

variable ZookeeperS3Bucket {
  type        = "string"
  description = "Bucket with ZK source bundle"
}

variable ZookeeperS3Key {
  type        = "string"
  description = "Key for ZK source bundle"
}

variable ZookeeperInstanceType {
  type        = "string"
  description = "The EC2 instance type"
}

variable ZookeeperDNSRecordName {
  type        = "string"
  description = "Route53 record for zookeeper round robin"
}

variable SolrCloudSize {
  type        = "number"
  description = "Desired number solr of instances"
}

variable SolrCloudMaxSize {
  type        = "number"
  description = "Maximum number solr of instances"
}

variable SolrSecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85."
}

variable SolrLBSecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85."
}

variable SolrHealthReportingSystemType {
  type        = "string"
  description = "Health reporting system"
}

variable SolrS3Bucket {
  type        = "string"
  description = "Bucket with ZK source bundle"
}

variable SolrS3Key {
  type        = "string"
  description = "Key for ZK source bundle"
}

variable SolrCloudInstanceType {
  type        = "string"
  description = "The EC2 instance type"
}

