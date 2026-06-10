resource "aws_sqs_queue" "main" {
  name = var.queue_name
}
