output "ApplicationName" {
  value = "${aws_elastic_beanstalk_application.hybox.name}"
}

output "VersionLabel" {
  value = "${aws_elastic_beanstalk_application_version.hybox.name}"
}

output "DefaultQueue" {
  value = "${aws_sqs_queue.default.arn}"
}

output "DefaultQueueName" {
  value = "${aws_sqs_queue.default.name}"
}

output "IamInstanceProfile" {
  value = "${aws_iam_instance_profile.application.arn}"
}

output "UploadBucket" {
  value = "${aws_s3_bucket.upload.arn}"
}

output "URL" {
  value = "${module.webapp.URL}"
}

output "WebappLBSecurityGroup" {
  value = "${module.webapp.SecurityGroupLB}"
}
