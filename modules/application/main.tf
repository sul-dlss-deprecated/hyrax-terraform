# Create queues for default messages, and to move dead messages to after a
# 5m delay.
resource "aws_sqs_queue" "default" {
  name                       = "default-queue"
  visibility_timeout_seconds = "3600"
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dead_letter.arn}\",\"maxReceiveCount\":5}"
}

resource "aws_sqs_queue" "dead_letter" {
  name                      = "dead-letter-queue"
}

# Create bucket for uploads.
resource "aws_s3_bucket" "upload" {
  bucket = "application-upload"

  # TODO = No current equivalent to the following:
  # DeletionPolicy = Retain
  # See https://github.com/terraform-providers/terraform-provider-aws/issues/902

  versioning {
    enabled = true
  }
}

# Application stack.
resource "aws_elastic_beanstalk_application" "hybox" {
  name        = "${var.StackName}"
  description = "Hybox service"
}

resource "aws_elastic_beanstalk_application_version" "hybox" {
  name        = "hybox-version-label"
  application = "${aws_elastic_beanstalk_application.hybox.name}"
  description = "Hybox service version"
  bucket      = "${var.S3BucketEB}"
  key         = "${var.S3Key}"
}

module codepipeline {
  source = "../../modules/codepipeline"

  ApplicationName       = "${aws_elastic_beanstalk_application.hybox.name}"
  WebappEnvironmentName = "${module.webapp.EnvironmentName}"
  WorkerEnvironmentName = "${module.worker.EnvironmentName}"
  S3Bucket              = "${var.S3BucketEB}"
  S3Key                 = "${var.S3Key}"
}

# Generate the worker application.
module worker {
  source = "../../modules/worker"

  StackName                  = "${var.StackName}"
  ApplicationName            = "${aws_elastic_beanstalk_application.hybox.name}"
  VersionLabel               = "${aws_elastic_beanstalk_application_version.hybox.name}"
  KeyName                    = "${var.KeyName}"
  MinSize                    = "${var.WorkerMinSize}"
  MaxSize                    = "${var.WorkerMaxSize}"
  PrivateSubnets             = "${var.PrivateSubnets}"
  SecurityGroups             = "${join(",", var.SecurityGroups)}"
  HostedZoneName             = "${var.HostedZoneName}"
  SecretKeyBase              = "${var.SecretKeyBase}"
  FcrepoUrl                  = "${var.FcrepoUrl}"
  SolrUrl                    = "${var.SolrUrl}"
  ZookeeperHosts             = "${var.ZookeeperHosts}"
  RedisHost                  = "${var.RedisHost}"
  RedisPort                  = "${var.RedisPort}"
  RDSDatabaseName            = "${var.RDSDatabaseName}"
  RDSUsername                = "${var.RDSUsername}"
  RDSPassword                = "${var.RDSPassword}"
  RDSHostname                = "${var.RDSHostname}"
  RDSPort                    = "${var.RDSPort}"
  QueuePrefix                = "${var.QueuePrefix}"
  DefaultQueue               = "${aws_sqs_queue.default.id}"
  DefaultQueueName           = "${aws_sqs_queue.default.name}"
  BeanstalkSNSTopic          = "${var.BeanstalkSNSTopic}"
  InstanceType               = "${var.WorkerInstanceType}"
  HealthReportingSystemType  = "${var.WorkerHealthReportingSystemType}"
  IamInstanceProfile         = "${aws_iam_instance_profile.application.arn}"
  UploadBucket               = "${aws_s3_bucket.upload.arn}"
  HoneybadgerApiKey          = "${var.HoneybadgerApiKey}"
  LogzioKey                  = "${var.LogzioKey}"
}

module webapp {
  source = "../../modules/webapp"

  vpc_id                     = "${var.vpc_id}"
  StackName                  = "${var.StackName}"
  ApplicationName            = "${aws_elastic_beanstalk_application.hybox.name}"
  VersionLabel               = "${aws_elastic_beanstalk_application_version.hybox.name}"
  KeyName                    = "${var.KeyName}"
  MinSize                    = "${var.WebappMinSize}"
  MaxSize                    = "${var.WebappMaxSize}"
  PublicSubnets              = "${var.PublicSubnets}"
  PrivateSubnets             = "${var.PrivateSubnets}"
  SecurityGroups             = "${join(",", var.SecurityGroups)}"
  HostedZoneName             = "${var.HostedZoneName}"
  SecretKeyBase              = "${var.SecretKeyBase}"
  FcrepoUrl                  = "${var.FcrepoUrl}"
  SolrUrl                    = "${var.SolrUrl}"
  ZookeeperHosts             = "${var.ZookeeperHosts}"
  RedisHost                  = "${var.RedisHost}"
  RedisPort                  = "${var.RedisPort}"
  RDSDatabaseName            = "${var.RDSDatabaseName}"
  RDSUsername                = "${var.RDSUsername}"
  RDSPassword                = "${var.RDSPassword}"
  RDSHostname                = "${var.RDSHostname}"
  RDSPort                    = "${var.RDSPort}"
  QueuePrefix                = "${var.QueuePrefix}"
  DefaultQueue               = "${aws_sqs_queue.default.arn}"
  BeanstalkSNSTopic          = "${var.BeanstalkSNSTopic}"
  InstanceType               = "${var.WebappInstanceType}"
  HealthReportingSystemType  = "${var.WebappHealthReportingSystemType}"
  IamInstanceProfile         = "${aws_iam_instance_profile.application.arn}"
  UploadBucket               = "${aws_s3_bucket.upload.arn}"
  SSLCertificateId           = "${var.SSLCertificateId}"
  GoogleAnalyticsId          = "${var.GoogleAnalyticsId}"
  EnableOpenSignup           = "${var.EnableOpenSignup}"
  DisableOpenTenantCreation  = "${var.DisableOpenTenantCreation}"
  AccountInvitationFromEmail = "${var.AccountInvitationFromEmail}"
  ContactEmail               = "${var.ContactEmail}"
  GeonamesUsername           = "${var.GeonamesUsername}"
  HoneybadgerApiKey          = "${var.HoneybadgerApiKey}"
  LogzioKey                  = "${var.LogzioKey}"
}
