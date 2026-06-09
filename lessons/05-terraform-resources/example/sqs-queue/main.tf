resource "aws_sqs_queue" "main" {
  name                        = "tf-example-queue"
  delay_seconds               = 5
  message_retention_seconds   = 604800
  receive_wait_time_seconds   = 10
  visibility_timeout_seconds  = 60
}
