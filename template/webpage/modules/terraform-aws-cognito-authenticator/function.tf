resource "random_string" "lambda" {
  length  = 8
  lower   = false
  numeric = false
  special = false
}

resource "aws_lambda_function" "default" {
  function_name = "AWSS3AuthenticatedWebsiteLambda${random_string.lambda.result}"
  description   = "Lambda intended to authenticate requests made to an AWS S3 bucket"

  s3_bucket         = lookup(var.lambda_function, "bucket")
  s3_key            = lookup(var.lambda_function, "key")
  s3_object_version = lookup(var.lambda_function, "version")
  source_code_hash  = lookup(var.lambda_function, "hash")

  publish = true
  handler = "index.handler"
  runtime = "nodejs14.x"
  role    = aws_iam_role.default.arn

  lifecycle {
    ignore_changes = [
      last_modified,
    ]
  }
}

variable "lambda_function" {
  type = object({
    bucket = string,
    key = string,
    version = string,
    hash = string,
  })
}