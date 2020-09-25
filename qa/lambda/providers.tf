provider "aws" {
  region = var.region
  # Mi defined profile in .aws/credentials
  profile = var.aws_profile
}

