data "aws_iam_role" "ec2" {
  name = "ec2-ssm-role"
}

resource "aws_iam_role_policy" "sqs_access" {
  role = data.aws_iam_role.ec2.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = module.sqs.queue_arn
      }
    ]
  })
}
