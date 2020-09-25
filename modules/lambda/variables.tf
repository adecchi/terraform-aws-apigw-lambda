# ------------- Variable definition for Lambda ----------------------------------

variable "filename" {
  description = "The file name with the extension, than we want to deploy on Lambda"
  type        = string
  default     = ""
}

variable "function_name" {
  description = "The function name"
  type        = string
  default     = ""
}

variable "handler" {
  description = "The file name with the extension, than we want to deploy on Lambda"
  type        = string
  default     = "lambda_handler"
}

# Valid Values: nodejs10.x | nodejs12.x | java8 | java11 | python2.7 | python3.6 | python3.7 | python3.8 | dotnetcore2.1 | dotnetcore3.1 | go1.x | ruby2.5 | ruby2.7 | provided
variable "runtime" {
  description = "The runtime of our application"
  type        = string
  default     = "python2.7"
}

variable "source_code_hash" {
  description = "Used to trigger updates"
  type        = string
}

variable "role" {
  description = "Role ARN"
  type        = string
}

