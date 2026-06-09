resource "aws_sqs_queue" "main" {
  count = length(var.queue_names)
  name  = "${var.queue_names[count.index]}-queue"
}
