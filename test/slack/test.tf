# Simple test of the slack module, seeing if the result is what we expect.
module slack {
  source = "../../modules/slack"

  # Not actually trying to connect to a working slack instance, so just give
  # random data that only goes into a javascript file.
  SlackWebhookToken   = "blah"
  SlackWebhookChannel = "blah"
}
