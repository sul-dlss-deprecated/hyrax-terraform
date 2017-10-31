# Simple test of the redis module, seeing if the result is what we expect.
module fcrepo {
  source = "../../modules/fcrepo"

  # TODO: Create a temp VPC and security group to use for this.
  # TODO: Run with apply once we've done that and can do full safe testing.

  vpc_id                 = "vpc-d84467b3"
  StackName              = "Fcrepo Test"
  SubnetID               = ""
  InstanceType           = "cache.m1.small"
  WebappSecurityGroup    = "sg-95966def"
  KeyName                = "test-hybox"
  S3Bucket               = "test-hybox-deployment-artifacts"
  S3Key                  = ""
  MinSize                = "1"
  MaxSize                = "2"
  HostedZoneName         = "testhydrainabox.org"
  RDSUsername            = "ebroot"
  RDSPassword            = "hiimapassword"
  RDSHostname            = "test.rds.org"
  RDSPort                = "5147"
  HomePath               = "/var/lib/fcrepo"
  BinaryStoreS3AccessKey = "s3accesskey"
  BinaryStoreS3SecretKey = "s3secretkey"
  BinaryStoreS3Bucket    = "bucketname"
}
