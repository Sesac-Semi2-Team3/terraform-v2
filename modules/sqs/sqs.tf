resource "aws_sqs_queue" "dlq" {
  name = "${var.queue_name}-dlq"
}

resource "aws_sqs_queue" "this" {
  name = var.queue_name

  visibility_timeout_seconds = var.visibility_timeout
  message_retention_seconds  = var.message_retention
  receive_wait_time_seconds = var.receive_wait_time_seconds
  max_message_size           = var.max_message_size

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 5
  })
}
