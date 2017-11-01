# Load the webapp.  The application and version are set up by what calls the
# module, and we are just passed the proper names.
resource "aws_elastic_beanstalk_environment" "webapp" {
  name          = "${var.StackName}-webapp"
  description   = "Hybox Environment"
  application   = "${var.ApplicationName}"
  template_name = "${aws_elastic_beanstalk_configuration_template.webapp.name}"
  version_label = "${var.VersionLabel}"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "STACK_NAME"
    value     = "${var.StackName}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SECRET_KEY_BASE"
    value     = "${var.SecretKeyBase}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RAILS_GROUPS"
    value     = "aws"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RAILS_SERVE_STATIC_FILES"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SOLR_URL"
    value     = "${var.SolrUrl}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__SOLR__URL"
    value     = "${var.SolrUrl}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "FEDORA_URL"
    value     = "${var.FcrepoUrl}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DISABLE_REDIS_CLUSTER"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "REDIS_HOST"
    value     = "${var.RedisHost}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "REDIS_PORT"
    value     = "${var.RedisPort}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__ZOOKEEPER__CONNECTION_STR"
    value     = "${var.ZookeeperHosts}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__MULTITENANCY__DEFAULT_HOST"
    value     = "${var.tenant}.${var.StackName}.${var.HostedZoneName}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__MULTITENANCY__ADMIN_HOST"
    value     = "${var.StackName}.${var.HostedZoneName}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__MULTITENANCY__ADMIN_ONLY_TENANT_CREATION"
    value     = "DisableOpenTenantCreation"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_DB_NAME"
    value     = "${var.RDSDatabaseName}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_USERNAME"
    value     = "${var.RDSUsername}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PASSWORD"
    value     = "${var.RDSPassword}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_HOSTNAME"
    value     = "${var.RDSHostname}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PORT"
    value     = "${var.RDSPort}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__ACTIVE_JOB__QUEUE_ADAPTER"
    value     = "better_active_elastic_job"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__ACTIVE_JOB_QUEUE__URL"
    value     = "${var.DefaultQueue}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DISABLE_SQS_CONSUMER"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_REGION"
    value     = "${var.region}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__S3__UPLOAD_BUCKET"
    value     = "${var.UploadBucket}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__GOOGLE_ANALYTICS_ID"
    value     = "${var.GoogleAnalyticsId}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__DEVISE__ACCOUNT_SIGNUP"
    value     = "${var.EnableOpenSignup}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__DEVISE__INVITATION_FROM_EMAIL"
    value     = "${var.AccountInvitationFromEmail}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__CONTACT_EMAIL"
    value     = "${var.ContactEmail}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__GEONAMES_USERNAME"
    value     = "${var.GeonamesUsername}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "HONEYBADGER_ENV"
    value     = "${var.StackName}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "HONEYBADGER_API_KEY"
    value     = "${var.HoneybadgerApiKey}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "LOGZIO_KEY"
    value     = "${var.LogzioKey}"
  }

  # TODO: This block in Cloudformation is wrapped in "If HasSSLCertificate",
  #       which doesn't have an equivalent.  How do we want to handle here?
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SETTINGS__SSL_CONFIGURED"
    value     = "true"
  }
  # ENDTODO
}

resource "aws_elastic_beanstalk_configuration_template" "webapp" {
  name                = "${var.StackName}-webapp-template"
  description         = "Hybox configuration template"
  application         = "${var.ApplicationName}"
  solution_stack_name = "64bit Amazon Linux 2017.03 v2.5.0 running Ruby 2.3 (Puma)"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.InstanceType}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${var.PrivateSubnets}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${var.PublicSubnets}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "${var.KeyName}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SSHSourceRestriction"
    value     = "tcp, 22, 22, 10.0.0.0/16"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${var.SecurityGroups}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "SecurityGroups"
    value     = "${var.SecurityGroups}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "ConnectionDrainingEnabled"
    value     = "true"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.webapp.name}"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "${var.MinSize}"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "${var.MaxSize}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Immutable"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "true"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateType"
    value     = "Health"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "/is_it_working"
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "${var.HealthReportingSystemType}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }
  setting {
    namespace = "aws:elasticbeanstalk:sns:topics"
    name      = "Notification Topic ARN"
    value     = "${var.BeanstalkSNSTopic}"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = "30"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = "CPUUtilization"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = "Maximum"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = "Percent"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = "85"
  }
  setting {
    namespace = "aws:elb:listener:80"
    name      = "ListenerProtocol"
    value     = "HTTP"
  }

  # TODO: This block in Cloudformation is wrapped in "If HasSSLCertificate",
  #       which doesn't have an equivalent.  How do we want to handle here?
  setting {
    namespace = "aws:elb:listener:443"
    name      = "SSLCertificateId"
    value     = "${var.SSLCertificateId}"
  }
  setting {
    namespace = "aws:elb:listener:443"
    name      = "InstancePort"
    value     = "80"
  }
  setting {
    namespace = "aws:elb:listener:443"
    name      = "ListenerProtocol"
    value     = "HTTPS"
  }
  ## End TODO

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "UpdateLevel"
    value     = "minor"
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "InstanceRefreshEnabled"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "PreferredStartTime"
    value     = "Sun:00:00"
  }
}
