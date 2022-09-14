variable "access_key" {
  type = string
  description = "aws access key"
}

variable "secret_key" {
  type = string
  description = "aws secret key"
}

variable "region" {
  type = string
  description = "aws region"
}

variable "bucket_name" {
  type = string
  description = "s3 bucket name"
}

variable "lambda_role_name" {
  type = string
  description = "lambda role name"
}

variable "lambda_function_name" {
  type = string
  description = "lambda function name"
}