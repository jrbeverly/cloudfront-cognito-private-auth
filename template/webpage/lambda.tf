resource "aws_s3_bucket" "storage" {
  bucket_prefix = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "artifact" {
  bucket = aws_s3_bucket.storage.id
  key    = "serverless/default.zip"
  source = "${path.module}/assets/lambda.zip"
  etag   = filemd5("${path.module}/assets/lambda.zip")
}
