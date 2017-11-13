resource "aws_elastic_beanstalk_application" "hyrax" {
  name = "hyrax"
}

resource "aws_s3_bucket" "beanstalk_source_bundles" {
  bucket = "hyrax-beanstalk-source-bundles"

  tags {
    Name = "hyrax beanstalk source bundles bucket"
    Terraform = "true"
  }
}

resource "aws_s3_bucket_object" "zookeeper" {
  bucket = "${aws_s3_bucket.beanstalk_source_bundles.id}"
  key    = "zookeeper/zookeeper-3.4.6.zip"
  source = "assets/zookeeper-3.4.6.zip"

  tags {
    Terraform = "true"
  }
}

resource "aws_elastic_beanstalk_application_version" "zookeeper" {
  name         = "3.4.6"
  application  = "${aws_elastic_beanstalk_application.hyrax.name}"
  bucket       = "${aws_s3_bucket.beanstalk_source_bundles.id}"
  key          = "${aws_s3_bucket_object.zookeeper.key}"
  force_delete = true

  depends_on = ["aws_s3_bucket_object.zookeeper"]
}

resource "aws_s3_bucket_object" "solr" {
  bucket = "${aws_s3_bucket.beanstalk_source_bundles.id}"
  key    = "solr/solr-6.5.zip"
  source = "assets/solr-6.5.zip"

  tags {
    Terraform = "true"
  }
}

resource "aws_elastic_beanstalk_application_version" "solr" {
  name         = "6.5"
  application  = "${aws_elastic_beanstalk_application.hyrax.name}"
  bucket       = "${aws_s3_bucket.beanstalk_source_bundles.id}"
  key          = "${aws_s3_bucket_object.solr.key}"
  force_delete = true

  depends_on = ["aws_s3_bucket_object.solr"]
}

resource "aws_s3_bucket_object" "fedora" {
  bucket = "${aws_s3_bucket.beanstalk_source_bundles.id}"
  key    = "fedora/fcrepo-4.8.0.war"
  source = "assets/fcrepo-4.8.0.war"

  tags {
    Terraform = "true"
  }
}

resource "aws_elastic_beanstalk_application_version" "fedora" {
  name        = "4.8.0"
  application = "${aws_elastic_beanstalk_application.hyrax.name}"
  bucket       = "${aws_s3_bucket.beanstalk_source_bundles.id}"
  key          = "${aws_s3_bucket_object.fedora.key}"
  force_delete = true

  depends_on = ["aws_s3_bucket_object.fedora"]
}

resource "aws_s3_bucket_object" "webapp" {
  bucket = "${aws_s3_bucket.beanstalk_source_bundles.id}"
  key    = "webapp/webapp-0.0.1.zip"
  source = "assets/webapp-0.0.1.zip"

  tags {
    Terraform = "true"
  }
}

resource "aws_elastic_beanstalk_application_version" "webapp" {
  name        = "0.0.1"
  application = "${aws_elastic_beanstalk_application.hyrax.name}"
  bucket      = "${aws_s3_bucket.beanstalk_source_bundles.id}"
  key         = "${aws_s3_bucket_object.webapp.key}"
  force_delete = true

  depends_on = ["aws_s3_bucket_object.webapp"]
}
