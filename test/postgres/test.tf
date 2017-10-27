# Simple test of the postgres module, seeing if the result is what we expect.
resource "aws_security_group" "postgresql_test" {
  vpc_id = "vpc-d84467b3"
  name   = "Postgresql Access Test"
}

module postgres {
  source = "../../modules/postgres"

  StackName          = "Postgresql test"
  DatabaseName       = "testing"
  MasterUsername     = "rootguy"
  MasterUserPassword = "changethispassword"

  SubnetID            = ""
  AccessSecurityGroup = "${aws_security_group.postgresql_test.id}"
  vpc_id              = "vpc-d84467b3"
}
