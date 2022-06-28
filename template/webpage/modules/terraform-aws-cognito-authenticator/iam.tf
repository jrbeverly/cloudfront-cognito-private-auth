data "aws_iam_policy_document" "default" {
  statement {
    sid    = "AllowAwsToAssumeRole"
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "edgelambda.amazonaws.com",
        "lambda.amazonaws.com",
      ]
    }
  }
}


resource "aws_iam_role" "default" {
  name_prefix        = "AWSS3AuthenticatedWebsiteLambda"
  description        = "Enables authenticated access to an AWS S3 bucket"
  path               = "/webpage/"
  assume_role_policy = data.aws_iam_policy_document.default.json
  tags = {
    "acme-purpose" : "Role for working with IAM roles"
  }
}

