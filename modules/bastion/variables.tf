variable vpc_id {
  type        = "string"
  description = "VPC id for resources"
}

variable region {
  type        = "string"
  description = "AWS region to use"
}

variable AWSRegionToAMI {
  type        = "map"
  description = "AMI to use for each region"
  default     = {
    us-east-1      = "ami-dd3dd7cb"
    us-west-1      = "ami-7d54061d"
    us-west-2      = "ami-3b6fd05b"
    eu-west-1      = "ami-47ecb121"
    ap-northeast-1 = "ami-78d6af1f"
    ap-southeast-2 = "ami-1e47407d"
    ap-southeast-1 = "ami-a0903ac3"
    eu-central-1   = "ami-7d0ec112"
  }
}

variable StackName {
  type        = "string"
  description = "Name of the ElasticBeanstalk environment"
}

variable SubnetID {
  type        = "string"
  description = "List of an existing subnet IDs to use for the load balancer and auto"
}

variable SecurityGroups {
  type        = "list"
  description = "A list of security groups, such as sg-a123fd85."
}

variable KeyName {
  type        = "string"
  description = "Name of an existing EC2 KeyPair to enable SSH access to the ECS instances"
}

variable InstanceType {
  type        = "string"
  description = "The EC2 instance type"
  default     = "t2.nano"
}
