# Actual direct beanstalk configuration for the fedora core.
resource "aws_elastic_beanstalk_application" "fedora" {
  name        = "${var.StackName}"
  description = "Fcrepo service"
}

resource "aws_elastic_beanstalk_environment" "fedora" {
  name          = "${var.StackName}"
  description   = "Fcrepo Environment"
  application   = "${aws_elastic_beanstalk_application.fedora.name}"
  template_name = "${aws_elastic_beanstalk_configuration_template.fedora.name}"
  version_label = "${aws_elastic_beanstalk_application_version.fedora.name}"
}

resource "aws_elastic_beanstalk_application_version" "fedora" {
  name        = "fcrepo-version-label"
  application = "${aws_elastic_beanstalk_application.fedora.name}"
  description = "Fcrepo service version"
  bucket      = "${var.S3Bucket}"
  key         = "${var.S3Key}"
}

resource "aws_elastic_beanstalk_configuration_template" "fedora" {
  name                = "fcrepo-template-config"
  description         = "Fcrepo configuration template"
  application         = "${aws_elastic_beanstalk_application.fedora.name}"
  solution_stack_name = "64bit Amazon Linux 2017.03 v2.6.5 running Tomcat 8 Java 8"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.InstanceType}"
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
    value     = "${join(",", var.SecurityGroups)}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "SecurityGroups"
    value     = "${aws_security_group.fedora_lb.id}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }
  setting {
    namespace = "aws:elb:policies"
    name      = "ConnectionDrainingEnabled"
    value     = "true"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internal"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${var.SubnetID}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${var.SubnetID}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.fedora.name}"
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
    namespace = "aws:autoscaling:trigger"
    name      = "LowerBreachScaleIncrement"
    value     = "0"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperBreachScaleIncrement"
    value     = "0"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Xmx"
    value     = "2g"
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Xms"
    value     = "2g"
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Dfcrepo.home"
    value     = "\"${var.HomePath}\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Dfcrepo.postgresql.host"
    value     = "\"${var.RDSHostname}\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Dfcrepo.postgresql.port"
    value     = "\"${var.RDSPort}\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Dfcrepo.postgresql.username"
    value     = "\"${var.RDSUsername}\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Dfcrepo.postgresql.password"
    value     = "\"${var.RDSPassword}\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Daws.accessKeyId"
    value     = "\"${var.BinaryStoreS3AccessKey}\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Daws.secretKey"
    value     = "\"${var.BinaryStoreS3SecretKey}\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Daws.bucket"
    value     = "\"${var.BinaryStoreS3Bucket}\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Dfcrepo.streaming.parallel"
    value     = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:container:tomcat:jvmoptions"
    name      = "Dfcrepo.modeshape.configuration"
    value     = "\"classpath:/config/jdbc-postgresql-s3/repository.json\""
  }
  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "/rest"
  }
  setting {
    namespace = "aws:elb:listener:80"
    name      = "ListenerProtocol"
    value     = "HTTP"
  }
}
