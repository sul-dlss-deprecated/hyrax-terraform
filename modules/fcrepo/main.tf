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
    value     = "${var.SecurityGroupsAll}"
  }
  setting {
    namespace = "aws:autoscaling:loadbalancer"
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
    name      = "JVM Options"
    value     = "${data.template_file.java_config.rendered}"
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

# Configuration for the java settings.
data "template_file" "java_config" {
  template = "${file("${path.module}/java.tpl")}"

  vars = {
    HomePath               = "${var.HomePath}"
    RDSHostname            = "${var.RDSHostname}"
    RDSPort                = "${var.RDSPort}"
    RDSUsername            = "${var.RDSUsername}"
    RDSPassword            = "${var.RDSPassword}"
    BinaryStoreS3AccessKey = "${var.BinaryStoreS3AccessKey}"
    BinaryStoreS3SecretKey = "${var.BinaryStoreS3SecretKey}"
    BinaryStoreS3Bucket    = "${var.BinaryStoreS3Bucket}"
  }
}
