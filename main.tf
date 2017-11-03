module "hyrax_vpc" {
  source = "./modules/vpc"

  private_hosted_zone_name = "${var.private_hosted_zone_name}"
}

module "hyrax_mail" {
  source = "./modules/mail"
}
