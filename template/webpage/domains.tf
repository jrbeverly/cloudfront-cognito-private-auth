locals {
  domain         = ".."
  backend        = "auth-alb"
  backend_alias  = "auth-alb.${local.domain}"
  frontend_alias = "auth-cloudfront.${local.domain}"
}
