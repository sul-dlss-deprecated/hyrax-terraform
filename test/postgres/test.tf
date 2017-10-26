# Simple test of the postgres module, seeing if the result is what we expect.
module postgres {
  source = "../../modules/postgres"

  StackName          = "Postgresql test"
  DatabaseName       = "testing"
  MasterUsername     = "rootguy"
  MasterUserPassword = "changethispassword"

  SubnetID            = ""
  AccessSecurityGroup = "sg-95966def"
}
