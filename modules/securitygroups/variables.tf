variable StackName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable VPC {
  type        = "aws::ec2::vpc::id"
  description = "A VPC ID, such as vpc-a123baa3"
}

