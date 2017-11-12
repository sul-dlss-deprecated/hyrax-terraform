resource "aws_s3_bucket" "fedora" {
  bucket = "${var.fedora_bucket_name}"
}
