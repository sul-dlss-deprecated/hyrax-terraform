variable StackName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable KeyName {
  type        = "aws::ec2::keypair::keyname"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
}

variable HostedZoneName {
  type        = "string"
  description = "Route53 zone to create internal aliases"
}

