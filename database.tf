module "database" {
  source = "modules/postgres"

  StackName           = "${var.StackName}"
  SubnetID            = "${module.hyrax_vpc.database_subnet_group}"
  vpc_id              = "${module.hyrax_vpc.vpc_id}"

  DatabaseName        = "${var.DatabaseName}"
  MasterUsername      = "${var.DatabaseUsername}"
  MasterUserPassword  = "${var.DatabasePassword}"
  DBInstanceClass     = "${var.DatabaseInstanceType}"
  AllocatedStorage    = "${var.DatabaseStorageSize}"
  MultiAZDatabase     = "${var.DatabaseMultiAZ}"
  SecurityGroupName   = "RDS security group"
  AccessSecurityGroup = "${aws_security_group.webapp.id}"

  # DatabasePassword should be set in terraform.tfvars.
}

module "fcrepodb" {
  source = "modules/postgres"

  StackName           = "${var.StackName}"
  SubnetID            = "${module.hyrax_vpc.database_subnet_group}"
  vpc_id              = "${module.hyrax_vpc.vpc_id}"

  DatabaseName        = "${var.FcrepoDatabaseName}"
  MasterUsername      = "${var.FcrepoDatabaseUsername}"
  MasterUserPassword  = "${var.FcrepoDatabasePassword}"
  DBInstanceClass     = "${var.FcrepoDatabaseInstanceType}"
  AllocatedStorage    = "${var.FcrepoDatabaseStorageSize}"
  MultiAZDatabase     = "${var.FcrepoDatabaseMultiAZ}"
  SecurityGroupName   = "Fedora RDS security group"
  AccessSecurityGroup = "${aws_security_group.fedora.id}"

  # FcrepoDatabasePassword should be set in terraform.tfvars.
}
