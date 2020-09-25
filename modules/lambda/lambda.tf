resource "aws_lambda_function" "aws_lambda" {
  filename         = var.filename
  function_name    = var.function_name
  role             = var.role
  handler          = var.handler
  source_code_hash = var.source_code_hash
  runtime          = var.runtime
}
output "invoke_arn" {
  value      = aws_lambda_function.aws_lambda.invoke_arn
  depends_on = [aws_lambda_function.aws_lambda]
}
