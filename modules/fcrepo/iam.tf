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
