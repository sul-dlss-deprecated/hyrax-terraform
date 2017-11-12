data "aws_iam_policy_document" "fedora_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "fedora" {
  name               = "fedora-role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.fedora_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "fedora-webtier" {
  role       = "${aws_iam_role.fedora.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "fedora-workertier" {
  role       = "${aws_iam_role.fedora.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_instance_profile" "fedora" {
  name = "fedora-profile"
  role = "${aws_iam_role.fedora.name}"
}

resource "aws_iam_user" "fedora" {
  name = "fedora-s3"
}

resource "aws_iam_access_key" "fedora" {
  user = "${aws_iam_user.fedora.name}"
}

resource "aws_iam_policy" "fedora_access_s3" {
  name = "fedora-access-s3"

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
        "arn:aws:s3:::${aws_s3_bucket.fedora.id}/*",
        "arn:aws:s3:::${aws_s3_bucket.fedora.id}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "fedora_user_s3" {
  user       = "${aws_iam_user.fedora.name}"
  policy_arn = "${aws_iam_policy.fedora_access_s3.arn}"
}
