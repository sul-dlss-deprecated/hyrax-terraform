# Lambda wants a zip file, and we have a template file that first needs to have
# a value filled.  First generate the final file from the template, then create
# a zipfile from it.
data "template_file" "slack" {
  template = "${file("${path.module}/source/slack.js.tmpl")}"

  vars {
    slack_webhook_token   = "${var.SlackWebhookToken}"
    slack_webhook_channel = "${var.SlackWebhookChannel}"
  }
}

data "archive_file" "slack" {
  type        = "zip"
  output_path = "slack.zip"
  source {
    content  = "${data.template_file.slack.rendered}"
    filename = "slack.js"
  }
}
