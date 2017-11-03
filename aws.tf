provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
  version = "~> 1.2"
}

terraform {
  backend "s3" {
    bucket = "hyrax-terraform-state"
    key    = "tfstate"
    region = "us-west-2"
  }
}
