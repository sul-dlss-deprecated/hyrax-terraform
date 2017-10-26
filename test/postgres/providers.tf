variable "aws_region" {
  default = "us-west-2"
}

# Default region.
provider "aws" {
  version = "~> 1.1"
  region  = "${var.aws_region}"
}
