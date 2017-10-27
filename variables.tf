variable "profile" {
  description = "AWS credentials profile"
  default = "default"
}

variable "region" {
  description = "AWS region to run resources in"
  default = "us-east-1"
}

variable "private_hosted_zone_name" {
  description = "Name for private hosted zone for private services"
  default = "hyrax.sul.stanford.edu"
}

variable KeyName {
  type        = "string"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
  default     = "hybox"
}

variable S3Bucket {
  type        = "string"
  description = "S3 bucket to the cfn deployment artifacts"
  default     = "hybox-deployment-artifacts"
}

variable S3BucketEB {
  type        = "string"
  description = "S3 bucket to the eb deployment artifacts"
  default     = "hybox-deployment-artifacts"
}

variable S3KeyPrefix {
  type        = "string"
  description = "S3 prefix to deployment artifacts"
  default     = "branch/branchname_here"
}

variable WebappS3Key {
  type        = "string"
  description = "S3 key to webapp deployment artifacts"
  default     = "hyku/current/hyku.zip"
}

variable PublicZoneName {
  type        = "string"
  description = "Existing Route53 zone; used to create a public DNS record for the"
  default     = "hydrainabox.org"
}

variable DatabaseUsername {
  type        = "string"
  description = "Database Root Username"
  default     = "ebroot"
}

variable DatabasePassword {
  type        = "string"
  description = "Password for the DB Root User"
  default     = ""
}

variable DatabaseName {
  type        = "string"
  description = "Name of the database"
  default     = "hybox"
}

variable DatabaseStorageSize {
  type        = "string"
  description = "Size of DB in Gigs"
  default     = "5"
}

variable DatabaseMultiAZ {
  type        = "string"
  description = "Launch the database in multiple availability zones"
  default     = "true"
}

variable BeanstalkHealthReportingSystemType {
  type        = "string"
  description = "Health reporting type for beanstalk apps"
  default     = "enhanced"
}

variable FcrepoDatabaseUsername {
  type        = "string"
  description = "Database Root Username"
  default     = "ebroot"
}

variable FcrepoDatabasePassword {
  type        = "string"
  description = "Password for the DB Root User"
  default     = ""
}

variable FcrepoDatabaseName {
  type        = "string"
  description = "Name of the database"
  default     = "fcrepo"
}

variable FcrepoDatabaseStorageSize {
  type        = "string"
  description = "Size of DB in Gigs"
  default     = "5"
}

variable FcrepoDatabaseMultiAZ {
  type        = "string"
  description = "Launch the database in multiple availability zones"
  default     = "true"
}

variable FcrepoHomePath {
  type        = "string"
  description = "Fcrepo home directory path"
  default     = "/var/lib/fcrepo"
}

variable FcrepoS3AccessKey {
  type        = "string"
  description = "Access Key Id for IAM user with access to Fcrepo bucket"
  default     = ""
}

variable FcrepoS3SecretKey {
  type        = "string"
  description = "Secret Access Key for IAM user with access to Fcrepo bucket"
  default     = ""
}

variable FcrepoS3BucketName {
  type        = "string"
  description = "Name of S3 bucket for Fedora binary content"
  default     = ""
}

variable SecretKeyBase {
  type        = "string"
  description = "Secret key for Rails"
  default     = ""
}

variable FcrepoInstanceType {
  type        = "string"
  description = "Instance type to launch"
  default     = "t2.large"
}

variable S3FedoraFilename {
  type        = "string"
  description = "S3 key to the Fcrepo war"
  default     = "fcrepo-webapp-4.8.0-SNAPSHOT.war"
}

variable FcrepoMinSize {
  type        = "string"
  description = "Minimum number of Fedora instances to launch"
  default     = "1"
}

variable FcrepoMaxSize {
  type        = "string"
  description = "Maximum number of Fedora instances to launch"
  default     = "2"
}

variable SolrCloudSize {
  description = "Number of Solr instances to launch"
  default     = "3"
}

variable SolrCloudInstanceType {
  type        = "string"
  description = "Instance type to launch"
  default     = "t2.large"
}

variable SolrCloudMaxSize {
  description = "Maximum number of instances that can be launched in your ECS cluster"
  default     = "3"
}

variable SolrS3Key {
  type        = "string"
  description = "S3 key for solr source bundle"
  default     = "solr.zip"
}

variable ZookeeperEnsembleSize {
  description = "Number of instances to launch"
  default     = "3"
}

variable ZookeeperEnsembleInstanceType {
  type        = "string"
  description = "Instance type to launch"
  default     = "t2.micro"
}

variable ZookeeperEnsembleMaxSize {
  type        = "string"
  description = "Max number of zks"
  default     = "3"
}

variable ZookeeperS3Key {
  type        = "string"
  description = "S3 key for zookeeper source bundle"
  default     = "zookeeper.zip"
}

variable ZookeeperDNSRecordName {
  type        = "string"
  description = "Docker Image for zks"
  default     = "zookeeper-ips"
}

variable WorkerInstanceType {
  type        = "string"
  description = "Instance type to launch"
  default     = "t2.medium"
}

variable WorkerMinSize {
  description = "Minimum number of instances to launch"
  default     = "1"
}

variable WorkerMaxSize {
  description = "Maximum number of instances to launch"
  default     = "4"
}

variable WebappInstanceType {
  type        = "string"
  description = "Instance type to launch"
  default     = "t2.large"
}

variable WebappMinSize {
  description = "Minimum number of instances to launch"
  default     = "1"
}

variable WebappMaxSize {
  description = "Maximum number of instances to launch"
  default     = "4"
}

variable RedisInstanceType {
  type        = "string"
  description = "Instance type to launch"
  default     = "cache.m1.small"
}

variable BastionInstanceType {
  type        = "string"
  description = "The EC2 instance type"
  default     = "t2.nano"
}

variable DatabaseInstanceType {
  type        = "string"
  description = "Instance type to launch"
  default     = "db.t2.medium"
}

variable FcrepoDatabaseInstanceType {
  type        = "string"
  description = "Instance type to launch"
  default     = "db.t2.medium"
}

variable SlackWebhookToken {
  type        = "string"
  description = "Slack generated token for Incoming Webhook"
  default     = ""
}

variable SlackWebhookChannel {
  type        = "string"
  description = "Slack channel for posting notifications"
  default     = ""
}

variable ContinuousDeployment {
  type        = "string"
  description = "Configure continuous deployment for the webapp and workers?"
  default     = "true"
}

variable QueuePrefix {
  type        = "string"
  description = "SQS Queue prefix"
  default     = "hybox"
}

variable SSLCertificateId {
  type        = "string"
  description = "The Amazon Resource Name (ARN) of the SSL certificate"
  default     = ""
}

variable GoogleAnalyticsId {
  type        = "string"
  description = "The Google Analytics id, e.g UA-111111-1"
  default     = ""
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
  default     = ""
}

variable GeonamesUsername {
  type        = "string"
  description = "The registered Geonames account name"
  default     = "jcoyne"
}

variable HoneybadgerApiKey {
  type        = "string"
  description = "The api key for honeybadger.io"
  default     = ""
}

variable LogzioKey {
  type        = "string"
  description = "The logz.io key"
  default     = ""
}
