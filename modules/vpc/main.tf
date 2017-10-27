data "aws_availability_zones" "available" {}

data "aws_region" "current" {
  current = true
}

module "hyrax_vpc" {
  name   = "${var.vpc_name}"
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  cidr                 = "10.0.0.0/16"
  public_subnets       = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
  private_subnets      = ["10.0.64.0/24","10.0.65.0/24","10.0.66.0/24"]
  database_subnets     = ["10.0.128.0/24","10.0.129.0/24","10.0.130.0/24"]
  elasticache_subnets  = ["10.0.192.0/24","10.0.193.0/24","10.0.194.0/24"]

  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_nat_gateway   = "${var.enable_nat_gateway}"
  single_nat_gateway   = "${var.single_nat_gateway}"
  enable_s3_endpoint   = "${var.enable_s3_endpoint}"

  azs      = ["${data.aws_availability_zones.available.names[0]}",
              "${data.aws_availability_zones.available.names[1]}",
              "${data.aws_availability_zones.available.names[2]}"]

  tags {
    "Name"      = "${var.vpc_name}"
    "Terraform" = "true"
  }
}

resource "aws_route53_zone" "hyrax" {
  count = "${var.create_private_hosted_zone}"

  name       = "${var.private_hosted_zone_name}"
  vpc_id     = "${module.hyrax_vpc.vpc_id}"
  vpc_region = "${data.aws_region.current.name}"
}
