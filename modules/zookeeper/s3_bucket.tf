resource "aws_s3_bucket" "zookeeper" {
  bucket = "${var.shared_configs_bucket_name}"
  force_destroy = "true"

  versioning {
    enabled = true
  }
}
