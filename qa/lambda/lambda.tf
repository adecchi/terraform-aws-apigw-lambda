# --------------------------- ROLE and POLICY ---------------------------------------------
module "decchi-iam-role" {
  # we call our module to create role and policies.
  source = "../../modules/iam"
}
# --------------------------- S3 Bucket ----------------------------------------------------
module "decchi-s3" {
  source = "../../modules/s3"
  # bucket name to create.
  bucket_name = "klarna-applications-bucket"
  # Name of the application to display in the bucket once the application is uploaded.
  key = "fibonacci_function.zip"
  # Path to the application
  source_path = "../../application/fibonacci_function.zip"
}
# ---------------------------- LAMBDA -------------------------------------------------------
module "fibonacci-lambda" {
  source = "../../modules/lambda"
  # Path file to our application to deploy in lambda
  filename = "../../application/fibonacci_function.zip"
  # Function Name to Display in the Lambda web console.
  function_name = "Fibonacci"
  # File Name where we define the entrypoint/handler of our application.
  handler          = "fibonacci.lambda_handler"
  role             = module.decchi-iam-role.iam_for_lambda
  source_code_hash = filebase64sha256("../../application/fibonacci_function.zip")
}

module "ackermann-lambda" {
  source = "../../modules/lambda"
  # Path file to our application to deploy in lambda
  filename = "../../application/ackermann_function.zip"
  # Function Name to Display in the Lambda web console.
  function_name = "Ackermann"
  # File Name where we define the entrypoint/handler of our application.
  handler          = "ackermann.lambda_handler"
  role             = module.decchi-iam-role.iam_for_lambda
  source_code_hash = filebase64sha256("../../application/ackermann_function.zip")
}

module "factorial-lambda" {
  source = "../../modules/lambda"
  # Path file to our application to deploy in lambda
  filename = "../../application/factorial_function.zip"
  # Function Name to Display in the Lambda web console.
  function_name = "Factorial"
  # File Name where we define the entrypoint/handler of our application.
  handler          = "factorial.lambda_handler"
  role             = module.decchi-iam-role.iam_for_lambda
  source_code_hash = filebase64sha256("../../application/factorial_function.zip")
}
# ---------------------------- API GW --------------------------------------------------------
module "fibonacci-apigw" {
  source        = "../../modules/apigw"
  apigw_name    = "decchi-apigw"
  uri           = module.fibonacci-lambda.invoke_arn
  path_part     = "fibonacci"
  function_name = "Fibonacci"
}

module "ackermann-apigw" {
  source        = "../../modules/apigw"
  apigw_name    = "decchi-apigw"
  uri           = module.ackermann-lambda.invoke_arn
  path_part     = "ackermann"
  function_name = "Ackermann"
}

module "factorial-apigw" {
  source        = "../../modules/apigw"
  apigw_name    = "decchi-apigw"
  uri           = module.factorial-lambda.invoke_arn
  path_part     = "factorial"
  function_name = "Factorial"
}
# --------------------------- OUTPUTS -----------------------------------------------------------
output "fibonacci_url" {
  value = "${module.fibonacci-apigw.base_url}/fibonacci"
}

output "ackermann_url" {
  value = "${module.ackermann-apigw.base_url}/ackermann"
}

output "factorial_url" {
  value = "${module.factorial-apigw.base_url}/factorial"
}
