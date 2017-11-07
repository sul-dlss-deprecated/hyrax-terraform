variable "region" {
  description = "AWS region to run resources in"
  default = "us-east-1"
}

variable StackName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable ApplicationName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable VersionLabel {
  type        = "string"
  description = "Name of the ElasticBeanstalk version"
}

variable KeyName {
  type        = "string"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
}

variable MinSize {
  type        = "string"
  description = "Minimum number of instances"
}

variable MaxSize {
  type        = "string"
  description = "Maximum number of instances"
}

variable PrivateSubnets {
  type        = "string"
  description = "List of an existing subnet IDs to use for the auto scaling group"
}

variable SecurityGroups {
  type        = "string"
  description = "A list of security groups, such as sg-a123fd85."
}

variable HostedZoneName {
  type        = "string"
  description = "Route53 zone to create an alias in"
}

variable SecretKeyBase {
  type        = "string"
  description = "Secret key for Rails"
}

variable FcrepoUrl {
  type        = "string"
  description = "URL to Fedora"
}

variable SolrUrl {
  type        = "string"
  description = "URL to Solr"
}

variable ZookeeperHosts {
  type        = "string"
  description = "A list of zookeeper host IP + ports"
}

variable RedisHost {
  type        = "string"
  description = "URL to Redis"
}

variable RedisPort {
  type        = "string"
  description = "Redis Port"
}

variable RDSDatabaseName {
  type        = "string"
  description = "Database name"
}

variable RDSUsername {
  type        = "string"
  description = "Username for Database"
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

variable QueuePrefix {
  type        = "string"
  description = "SQS Queue prefix"
}

variable DefaultQueue {
  type        = "string"
  description = "SQS Default Queue"
}

variable DefaultQueueName {
  type        = "string"
  description = "SQS Default Queue Name"
}

variable IamInstanceProfile {
  type        = "string"
  description = "ARN for an IAM profile to assign to the EC2 instances"
}

variable UploadBucket {
  type        = "string"
  description = "S3 Bucket to store uploaded files into"
}

variable InstanceType {
  type        = "string"
  description = "The EC2 instance type"
}

variable HealthReportingSystemType {
  type        = "string"
  description = "Health reporting system"
}

variable BeanstalkSNSTopic {
  type        = "string"
  description = "SNS Topic for Beanstalk application to write change events to"
}

variable HoneybadgerApiKey {
  type        = "string"
  description = "The api key for honeybadger.io"
}

variable LogzioKey {
  type        = "string"
  description = "The logz.io key"
}
