resource "aws_iam_role" "iam_for_lambda" {
  name = var.lambda_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir = "${path.module}/lambda"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_s3_object" "lambda_file_upload" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = "lambda.zip"
  source = data.archive_file.lambda_zip.output_path
}

resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "handler.lambda_function"

  s3_bucket   = aws_s3_bucket.s3_bucket.id
  s3_key      = aws_s3_object.lambda_file_upload.key

  runtime = "python3.7"
}