# Simple test of the codepipeline module, seeing if the result is what we expect.
module codepipeline {
  source = "../../modules/codepipeline"

  S3Bucket              = "hybox-deployment-artifacts"
  S3Key                 = ""
  ApplicationName       = "Happy Test Application"
  WebappEnvironmentName = "Web application"
  WorkerEnvironmentName = "Worker"
}
