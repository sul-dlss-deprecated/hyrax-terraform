# Set up the iam role and policy for the code pipeline.
data "aws_iam_policy_document" "codepipeline" {
  statement {
    actions = [
      "arn:aws:s3:::codepipeline*",
      "arn:aws:s3:::elasticbeanstalk"
    ]
    resources = [
      "s3:PutObject"
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:UploadArchive",
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision",
      "elasticbeanstalk:*",
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*",
      "iam:PassRole",
      "lambda:InvokeFunction",
      "lambda:ListFunctions"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "codepipeline_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codepipeline" {
  name = "codepipeline-role"
  assume_role_policy = "${data.aws_iam_policy_document.codepipeline_assume_role.json}"
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline_policy"
  role   = "${aws_iam_role.codepipeline.id}"
  policy = "${data.aws_iam_policy_document.codepipeline.json}"
}
