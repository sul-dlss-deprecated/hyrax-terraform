variable vpc_id {
  type        = "string"
  description = "VPC identifier"
}

variable "region" {
  description = "AWS region to run resources in"
  default = "us-east-1"
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

variable S3Bucket {
  type        = "string"
  description = "S3 bucket with cloudformation templates"
  default     = "hybox-deployment-artifacts"
}

variable S3BucketEB {
  type        = "string"
  description = "S3 bucket with the hyku zip"
  default     = "hybox-deployment-artifacts"
}

variable S3Key {
  type        = "string"
  description = "S3 key to the hyku zip"
}

variable S3KeyPrefix {
  type        = "string"
  description = "S3 prefix to deployment artifacts"
}

variable WebappMinSize {
  type        = "string"
  description = "Minimum number of instances"
}

variable WebappMaxSize {
  type        = "string"
  description = "Maximum number of instances"
}

variable WorkerMinSize {
  type        = "string"
  description = "Minimum number of instances"
}

variable WorkerMaxSize {
  type        = "string"
  description = "Maximum number of instances"
}

variable PublicSubnets {
  type        = "string"
  description = "List of an existing subnet IDs to use for the load balancer"
}

variable PrivateSubnets {
  type        = "string"
  description = "List of an existing subnet IDs to use for the auto scaling group"
}

variable SecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85."
}

variable HostedZoneName {
  type        = "string"
  description = "Route53 zone to create an alias in"
  default     = "hydrainabox.org"
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
  default     = "hybox"
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

variable QueuePrefix {
  type        = "string"
  description = "SQS Queue prefix"
  default     = "hybox"
}

variable WebappInstanceType {
  type        = "string"
  description = "The EC2 instance type"
  default     = "t2.large"
}

variable WorkerInstanceType {
  type        = "string"
  description = "The EC2 instance type"
  default     = "t2.medium"
}

variable WebappHealthReportingSystemType {
  type        = "string"
  description = "Health reporting system"
}

variable WorkerHealthReportingSystemType {
  type        = "string"
  description = "Health reporting system"
}

variable BeanstalkSNSTopic {
  type        = "string"
  description = "SNS Topic for Beanstalk application to write change events to"
}

variable ContinuousDeployment {
  type        = "string"
  description = "Configure continuous deployment for the webapp and workers?"
  default     = "true"
}

variable SSLCertificateId {
  type        = "string"
  description = "The Amazon Resource Name (ARN) of the SSL certificate"
}

variable GoogleAnalyticsId {
  type        = "string"
  description = "The Google Analytics id, e.g UA-111111-1"
}

variable EnableOpenSignup {
  type        = "string"
  description = "True to allow open self-signup, false to disable"
  default     = "true"
}

variable DisableOpenTenantCreation {
  type        = "string"
  description = "True to restrict tenant creation to admins, false to open creation to any registered users"
  default     = "false"
}

variable AccountInvitationFromEmail {
  type        = "string"
  description = "Email address from which account invitations are sent"
  default     = "hyku-invitations@example.com"
}

variable ContactEmail {
  type        = "string"
  description = "Email address to which contact form messages are sent"
}

variable GeonamesUsername {
  type        = "string"
  description = "The registered Geonames account name"
  default     = "jcoyne"
}

variable HoneybadgerApiKey {
  type        = "string"
  description = "The api key for honeybadger.io"
}

variable LogzioKey {
  type        = "string"
  description = "The logz.io key"
}
