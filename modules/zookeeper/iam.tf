resource "aws_iam_role" "iam_for_zookeeper" {
  name = "iam-for-zookeeper"

  assume_role_policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Action" : "sts:AssumeRole",
      "Principal" : {
        "Service" : "ec2.amazonaws.com"
      },
      "Effect" : "Allow",
      "Sid" : ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "zookeeper_access_s3" {
  name = "zookeeper-access-s3"

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
        "arn:aws:s3:::${aws_s3_bucket.zookeeper.id}/*",
        "arn:aws:s3:::${aws_s3_bucket.zookeeper.id}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "managed_beanstalk_webtier" {
  role       = "${aws_iam_role.iam_for_zookeeper.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "zookeeper_access_s3" {
  role       = "${aws_iam_role.iam_for_zookeeper.name}"
  policy_arn = "${aws_iam_policy.zookeeper_access_s3.arn}"
}

resource "aws_iam_instance_profile" "zookeeper_profile" {
  name = "zookeeper-profile"
  role = "${aws_iam_role.iam_for_zookeeper.name}"
}
