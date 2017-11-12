data "aws_elastic_beanstalk_solution_stack" "tomcat" {
  most_recent = true
  name_regex  = "^64bit Amazon Linux (.*) running Tomcat (.*) Java (.*)$"
}

resource "aws_elastic_beanstalk_environment" "fedora" {
  name                = "${var.environment_name}"
  cname_prefix        = "${var.environment_cname}"
  application         = "${var.application_name}"
  version_label       = "${var.version_label}"
  solution_stack_name = "${data.aws_elastic_beanstalk_solution_stack.tomcat.name}"

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "${var.min_size}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "${var.max_size}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "${var.key_name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.fedora.name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "${var.instance_type}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${join(",", var.instance_security_groups)}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SSHSourceRestriction"
    value     = "tcp,22,22,10.0.0.0/16"
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
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.vpc_id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internal"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${join(",", var.subnets)}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = "${join(",", var.subnets)}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "/rest"
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
    value     = "-Dfcrepo.home=\"/var/lib/fcrepo\" -Dfcrepo.postgresql.host=\"${module.fcrepodb.address}\" -Dfcrepo.postgresql.port=\"${module.fcrepodb.port}\" -Dfcrepo.postgresql.username=\"${module.fcrepodb.username}\" -Dfcrepo.postgresql.password=\"${var.db_password}\" -Daws.accessKeyId=\"${aws_iam_access_key.fedora.id}\" -Daws.secretKey=\"${aws_iam_access_key.fedora.secret}\" -Daws.bucket=\"${aws_s3_bucket.fedora.id}\" -Dfcrepo.streaming.parallel=true -Dfcrepo.modeshape.configuration=\"classpath:/config/jdbc-postgresql-s3/repository.json\""
    # value     = "${data.template_file.java_options.rendered}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "false"
  }

  setting {
    namespace = "aws:elb:listener:80"
    name      = "ListenerProtocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "CrossZone"
    value     = "true"
  }

  setting {
    namespace = "aws:elb:loadbalancer"
    name      = "SecurityGroups"
    value     = "${join(",", var.lb_security_groups)}"
  }

  setting {
    namespace = "aws:elb:policies"
    name      = "ConnectionDrainingEnabled"
    value     = "true"
  }
}
