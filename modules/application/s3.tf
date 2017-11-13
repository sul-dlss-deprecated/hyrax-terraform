# Do we need DeletionPolicy: Retain
# or was that just a cfn thing?
resource "aws_s3_bucket" "upload" {
  bucket = "${var.application_upload_bucket_name}"

  versioning {
    enabled = true
  }
}
