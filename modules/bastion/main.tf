data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_region" "current" {
  current = true
}

resource "aws_cloudformation_stack" "bastion" {
  name = "bastion-asg-${var.vpc_id}"
  timeout_in_minutes = 20

  parameters {
    LaunchConfigurationName = "${aws_launch_configuration.bastion.name}"
    VPCZoneIdentifier = "${join(",", var.subnets)}"
  }

  template_body = <<STACK
{
  "Parameters" : {
    "LaunchConfigurationName" : {
      "Type" : "String"
    },
    "VPCZoneIdentifier" : {
      "Type" : "CommaDelimitedList"
    }
  },
  "Resources" : {
    "BastionAsg" : {
      "Type" : "AWS::AutoScaling::AutoScalingGroup",
      "Properties" : {
        "VPCZoneIdentifier" : { "Ref" : "VPCZoneIdentifier" },
        "LaunchConfigurationName" : { "Ref" : "LaunchConfigurationName" },
        "MaxSize" : "2",
        "MinSize" : "1",
        "DesiredCapacity" : "1",
        "Tags" : [
          {
            "Key" : "Name",
            "Value" : "bastion-asg",
            "PropagateAtLaunch" : "true"
          }
        ]
      },
      "CreationPolicy" : {
        "ResourceSignal" : {
          "Timeout" : "PT25M"
        }
      },
      "UpdatePolicy" : {
        "AutoScalingRollingUpdate" : {
          "MinInstancesInService" : "1",
          "MaxBatchSize" : "1",
          "PauseTime" : "PT5M",
          "WaitOnResourceSignals" : "true"
        }
      }
    }
  }
}
STACK
}

resource "aws_launch_configuration" "bastion" {
  name_prefix     = "bastion-lc-"
  image_id        = "${data.aws_ami.amazon_linux.id}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${var.security_groups}"]
  key_name        = "${var.key_name}"

  user_data = <<EOF
#!/bin/bash -xe
yum update -y
/opt/aws/bin/cfn-signal -e $? --stack bastion-asg-${var.vpc_id} --resource BastionAsg --region ${data.aws_region.current.name}
EOF

  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}
