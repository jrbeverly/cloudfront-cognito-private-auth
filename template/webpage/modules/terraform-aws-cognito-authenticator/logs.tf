resource "aws_cloudwatch_log_group" "logs" {
  name = "/aws/lambda/${aws_lambda_function.default.function_name}"
}

data "aws_iam_policy_document" "logs" {
  statement {
    sid = "AllowCRWLogs"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup",
    ]
  }
}

resource "aws_iam_role_policy" "logs" {
  name   = "AWSCloudWatchLogs"
  role   = aws_iam_role.default.id
  policy = data.aws_iam_policy_document.logs.json
}
