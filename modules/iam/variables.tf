# ------------- Variable Definition for Roles ----------------------------------

variable "iam_role_lambda_name" {
  description = "The IAM Role Name for Lambda"
  type        = string
  default     = "iam_role_lambda"
}

variable "assume_role_policy" {
  description = "The IAM Policy"
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

variable "iam_policy_for_lambda_name" {
  description = "The IAM Policy Name for Lambda"
  type        = string
  default     = "iam_policy_for_lambda"
}

variable "iam_policy_for_lambda" {
  description = "The IAM Policy for Lambda"
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "logs:*"
        ],
        "Resource": "arn:aws:logs:*:*:*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": "arn:aws:s3:::*"
    }
]
} 
EOF
}
