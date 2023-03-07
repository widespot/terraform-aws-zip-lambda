output "lambda_arn" {
  value = aws_lambda_function.this.arn
  description = "Amazon Resource Name (ARN) identifying your Lambda Function"
}

output "lambda_qualified_arn" {
  value = aws_lambda_function.this.qualified_arn
  description = "ARN identifying your Lambda Function Version"
}

output "lambda_version" {
  value = aws_lambda_function.this.version
  description = "Latest published version of your Lambda Function"
}
