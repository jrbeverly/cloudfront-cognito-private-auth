resource "random_string" "pool" {
  length  = 8
  lower   = false
  numeric = false
  special = false
}

resource "aws_cognito_user_pool" "pool" {
  name = "AWSS3AuthenticatedWebsiteLambda${random_string.pool.result}"
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = local.backend
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_client" "client" {
  name            = "AWSS3AuthenticatedWebsiteLambda${random_string.pool.result}"
  user_pool_id    = aws_cognito_user_pool.pool.id
  generate_secret = true

  supported_identity_providers         = ["COGNITO"]
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = ["email", "openid"]

  callback_urls = [
    "https://${local.backend_alias}/oauth2/idpresponse",
    "https://${local.frontend_alias}",
  ]

  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]
}

output "client_id" {
  value = aws_cognito_user_pool_client.client.id
}

output "userpool_id" {
  value = aws_cognito_user_pool.pool.id
}