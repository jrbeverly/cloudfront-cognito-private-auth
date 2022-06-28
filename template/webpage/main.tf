module "aws_cognito_authenticator" {
  source  = "./modules/terraform-aws-cognito-authenticator"

  lambda_function  = {
    bucket = aws_s3_bucket.storage.id,
    key = aws_s3_object.artifact.id,
    version = aws_s3_object.artifact.version_id,
    hash = filemd5("${path.module}/assets/lambda.zip"),
  }

  configuration = {
    COGNITO_CLIENT_SECRET = aws_cognito_user_pool_client.client.client_secret
  }
}