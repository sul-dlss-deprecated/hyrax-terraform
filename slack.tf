module "slack" {
  source = "modules/slack"

  SlackWebhookToken   = "${var.SlackWebhookToken}"
  SlackWebhookChannel = "${var.SlackWebhookChannel}"
}
