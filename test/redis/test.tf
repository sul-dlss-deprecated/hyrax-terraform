# Simple test of the redis module, seeing if the result is what we expect.
module redis {
  source = "../../modules/redis"

  StackName           = "Redis Test"
  SubnetID            = ""
  InstanceType        = "cache.m1.small"
  WebappSecurityGroup = "sg-95966def"
}
