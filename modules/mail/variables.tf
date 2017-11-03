variable "hosted_zone_name" {
  description = "Hosted Zone name for email records to be created within"
}

variable "application_domain" {
  description = "Domain name for the application"
}

variable "mail_bucket_name" {
  description = "Bucket name for receiving emails"
}
