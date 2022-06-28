module "cloudfront" {
  source = "./modules/terraform-aws-cloudfront-s3-cdn"

  namespace               = "AWSS3AuthenticatedWebsiteLambda"
  name                    = random_string.pool.result
  comment                 = "Frontend for the service with CloudFront"
  encryption_enabled      = true
  allow_ssl_requests_only = false

  aliases          = [local.frontend_alias]
  parent_zone_name = local.domain

  cors_allowed_origins = ["*"]
  cors_allowed_headers = ["Authorization"]

  website_enabled = true
  index_document  = "index.html"
  error_document  = "index.html"

  lambda_function_association = [{
    event_type   = "viewer-request"
    include_body = false
    lambda_arn   = module.lambda-at-edge.arn
  }]
}

resource "aws_s3_object" "website" {
  bucket       = module.cloudfront.s3_bucket
  key          = "index.html"
  content      = "<h1>Hidden website</h1>"
  content_type = "text/html"
}
