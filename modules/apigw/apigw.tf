resource "aws_api_gateway_rest_api" "apigw" {
  name        = var.apigw_name
  description = "API GW Endpoint"
}

resource "aws_api_gateway_resource" "apigw-proxy" {
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  parent_id   = aws_api_gateway_rest_api.apigw.root_resource_id
  path_part   = var.path_part
  depends_on  = [aws_api_gateway_rest_api.apigw]
}

resource "aws_api_gateway_method" "apigw-proxy-method" {
  rest_api_id   = aws_api_gateway_rest_api.apigw.id
  resource_id   = aws_api_gateway_resource.apigw-proxy.id
  http_method   = "POST"
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.apigw, aws_api_gateway_resource.apigw-proxy]
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  resource_id = aws_api_gateway_method.apigw-proxy-method.resource_id
  http_method = aws_api_gateway_method.apigw-proxy-method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.uri
  depends_on              = [aws_api_gateway_rest_api.apigw, aws_api_gateway_method.apigw-proxy-method]
}

# ----
resource "aws_api_gateway_method" "apigw-proxy-root" {
  rest_api_id   = aws_api_gateway_rest_api.apigw.id
  resource_id   = aws_api_gateway_rest_api.apigw.root_resource_id
  http_method   = "POST"
  authorization = "NONE"
  depends_on    = [aws_api_gateway_rest_api.apigw]
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  resource_id = aws_api_gateway_method.apigw-proxy-root.resource_id
  http_method = aws_api_gateway_method.apigw-proxy-root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.uri
  depends_on              = [aws_api_gateway_rest_api.apigw, aws_api_gateway_method.apigw-proxy-root]

}

# -- Allow API GW access to Lambda --
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.apigw.execution_arn}/*/*"
  depends_on    = [aws_api_gateway_rest_api.apigw]
}
# -- Deployment --
resource "aws_api_gateway_deployment" "apigw-deploy" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
    aws_api_gateway_rest_api.apigw
  ]

  rest_api_id = aws_api_gateway_rest_api.apigw.id
  stage_name  = "test"
}

# -- OUTPUT --
output "base_url" {
  value      = aws_api_gateway_deployment.apigw-deploy.invoke_url
  depends_on = [aws_api_gateway_deployment.apigw-deploy]
}
