resource "aws_ses_receipt_rule_set" "hyrax" {
  rule_set_name = "hyrax-rule-set"
}

resource "aws_ses_receipt_rule" "hyrax" {
  name          = "hyrax-rule"
  rule_set_name = "hyrax-rule-set"
  recipients    = ["${var.application_domain}"]
  enabled       = true
  scan_enabled  = true
  depends_on = ["aws_ses_receipt_rule_set.hyrax","aws_s3_bucket_policy.hyrax_mail_policy"]

  s3_action {
    bucket_name = "${aws_s3_bucket.hyrax_mail.id}"
    object_key_prefix = "email"
    position = 1
  }
}

resource "aws_ses_domain_identity" "hyrax" {
  domain = "${var.application_domain}"
}

resource "aws_route53_record" "hyrax_amazonses_verification_record" {
  zone_id = "${data.aws_route53_zone.selected.id}"
  name    = "_amazonses.${var.application_domain}"
  type    = "TXT"
  ttl     = "9000"
  records = ["${aws_ses_domain_identity.hyrax.verification_token}"]
}

resource "aws_ses_domain_dkim" "hyrax" {
  domain = "${aws_ses_domain_identity.hyrax.domain}"
}

resource "aws_route53_record" "hyrax_domainkey_records" {
  count   = 3
  zone_id = "${data.aws_route53_zone.selected.id}"
  name    = "${element(aws_ses_domain_dkim.hyrax.dkim_tokens, count.index)}._domainkey.${var.application_domain}"
  type    = "CNAME"
  ttl     = "9000"
  records = ["${element(aws_ses_domain_dkim.hyrax.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
