resource "aws_iam_role" "iam_for_lambda" {
  name               = var.iam_role_lambda_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name       = var.iam_policy_for_lambda_name
  policy     = var.iam_policy_for_lambda
  depends_on = [aws_iam_role.iam_for_lambda]
}


resource "aws_iam_role_policy_attachment" "lambda-attach-policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
  depends_on = [aws_iam_role.iam_for_lambda, aws_iam_policy.iam_policy_for_lambda]
}

output "iam_for_lambda" {
  value = aws_iam_role.iam_for_lambda.arn
}
