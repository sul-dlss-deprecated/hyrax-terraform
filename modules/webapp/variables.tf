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
  type        = "aws::ec2::keypair::keyname"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
}

variable MinSize {
  type        = "number"
  description = "Minimum number of instances"
}

variable MaxSize {
  type        = "number"
  description = "Maximum number of instances"
}

variable PublicSubnets {
  type        = "list"
  description = "List of an existing subnet IDs to use for the load balancer"
}

variable PrivateSubnets {
  type        = "list"
  description = "List of an existing subnet IDs to use for the auto scaling group"
}

variable SecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85."
}

variable LBSecurityGroups {
  type        = "list"
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

  noecho      = "'true'"
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

  noecho      = "'true'"
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
}

variable DisableOpenTenantCreation {
  type        = "string"
  description = "True to restrict tenant creation to admins, false to open creation to any registered users"
}

variable AccountInvitationFromEmail {
  type        = "string"
  description = "Email address from which account invitations are sent"
}

variable ContactEmail {
  type        = "string"
  description = "Email address to which contact form messages are sent"
}

variable GeonamesUsername {
  type        = "string"
  description = "The registered Geonames account name"
}

variable HoneybadgerApiKey {
  type        = "string"
  description = "The api key for honeybadger.io"
}

variable LogzioKey {
  type        = "string"
  description = "The logz.io key"
}

