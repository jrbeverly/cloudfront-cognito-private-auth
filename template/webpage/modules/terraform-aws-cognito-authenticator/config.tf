locals {
  is_configuration_params_provided = length(var.configuration) > 0 ? 1 : 0
}

resource "aws_ssm_parameter" "lambda_config" {
  for_each = var.configuration

  name  = each.key
  type  = "SecureString"
  value = each.value

  description = "Parameter ${each.key} for the lambda function ${aws_lambda_function.default.function_name}"
  tier        = length(each.value) > 4096 ? "Advanced" : "Standard"
}

data "aws_iam_policy_document" "lambda_config" {
  count = local.is_configuration_params_provided

  statement {
    sid    = "AllowReadAWSSSM"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "secretsmanager:GetSecretValue",
    ]
    resources = [
      for name, outputs in aws_ssm_parameter.lambda_config :
      outputs.arn
    ]
  }
}

resource "aws_iam_policy" "lambda_config" {
  count = local.is_configuration_params_provided

  name        = "AWSLambdaSSMConfiguration"
  description = "Enable the lambda function ${aws_lambda_function.default.function_name} to source configuration parameters from AWS SSM"
  policy      = data.aws_iam_policy_document.lambda_config[0].json
}

resource "aws_iam_role_policy_attachment" "lambda_config" {
  count = local.is_configuration_params_provided

  role       = aws_iam_role.default.id
  policy_arn = aws_iam_policy.lambda_config[0].arn
}

variable "configuration" {
  type        = map(string)
  default     = {}
  description = "Configuration properties for the Lambda"
}
