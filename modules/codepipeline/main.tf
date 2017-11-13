# TODO = No current equivalent to the following for the S3 bucket:
# DeletionPolicy = Retain
# See https://github.com/terraform-providers/terraform-provider-aws/issues/902

# Create the bucket we currently use to hold the source.
resource "aws_s3_bucket" "codepipeline" {
  bucket = "artifact-store-${var.ApplicationName}"
  versioning {
    enabled = true
  }

  tags {
    Name      = "${var.StackName}-codepipeline-s3"
    Terraform = "true"
  }
}

# Create the code pipeline that will take the source and release to the
# webapp and worker environments.
resource "aws_codepipeline" "hyrax" {
  name     = "hyrax-codepipeline-${var.ApplicationName}"
  role_arn = "${aws_iam_role.codepipeline.arn}"

  artifact_store {
    location = "${aws_s3_bucket.codepipeline.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration {
        S3Bucket    = "${var.S3Bucket}"
        S3ObjectKey = "${var.S3Key}"
      }
    }
  }

  stage {
    name = "Release"

    action {
      name            = "ReleaseWebapp"
      run_order       = "1"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["SourceOutput"]
      version         = "1"

      configuration {
        ApplicationName = "${var.ApplicationName}"
        EnvironmentName = "${var.WebappEnvironmentName}"
      }
    }

    action {
      name            = "ReleaseWorkers"
      run_order       = "2"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["SourceOutput"]
      version         = "1"

      configuration {
        ApplicationName = "${var.ApplicationName}"
        EnvironmentName = "${var.WorkerEnvironmentName}"
      }
    }
  }
}
