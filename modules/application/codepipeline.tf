# module codepipeline {
#   source = "../../modules/codepipeline"
#
#   ApplicationName       = "${aws_elastic_beanstalk_application.hybox.name}"
#   WebappEnvironmentName = "${module.webapp.EnvironmentName}"
#   WorkerEnvironmentName = "${module.worker.EnvironmentName}"
#   S3Bucket              = "${var.S3BucketEB}"
#   S3Key                 = "${var.S3Key}"
# }
