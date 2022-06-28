output "arn" {
  value = "${aws_lambda_function.default.arn}:${aws_lambda_function.default.version}"
}
