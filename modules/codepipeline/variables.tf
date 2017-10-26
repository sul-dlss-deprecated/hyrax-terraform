variable S3Bucket {
  type        = "string"
  description = "S3 Bucket of the deployment artifact"
}

variable S3Key {
  type        = "string"
  description = "S3 Key of the deployment artifact"
}

variable ApplicationName {
  type        = "string"
  description = "ElasticBeanstalk Application Name"
}

variable WebappEnvironmentName {
  type        = "string"
  description = "ElasticBeanstalk Application Environment"
}

variable WorkerEnvironmentName {
  type        = "string"
  description = "ElasticBeanstalk Application Environment"
}

