resource "aws_sqs_queue" "queue" {
  name = var.queue_name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:*:*:${var.queue_name}",
      "Condition": {
        "ArnEquals": { "aws:SourceArn": "${aws_s3_bucket.s3_bucket.arn}" }
      }
    }
  ]
}
POLICY
}
