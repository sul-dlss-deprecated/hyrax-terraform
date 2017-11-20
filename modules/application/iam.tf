data "aws_iam_policy_document" "application_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "application" {
  name               = "application-role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.application_assume_role.json}"
}

resource "aws_iam_policy" "application" {
  name   = "application-policy"

  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Action" : [
        "s3:*"
      ],
      "Effect" : "Allow",
      "Resource" : [
        "arn:aws:s3:::${aws_s3_bucket.upload.id}/*",
        "arn:aws:s3:::${aws_s3_bucket.upload.id}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "application_s3" {
  role       = "${aws_iam_role.application.name}"
  policy_arn = "${aws_iam_policy.application.arn}"
}

resource "aws_iam_role_policy_attachment" "application_webtier" {
  role       = "${aws_iam_role.application.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "application_workertier" {
  role       = "${aws_iam_role.application.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_role_policy_attachment" "application_sqs" {
  role       = "${aws_iam_role.application.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_instance_profile" "application" {
  name = "application-profile"
  role = "${aws_iam_role.application.name}"
}
