variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "aws_profile" {
  default = "user-teste-sre"
  type    = string
}

variable "bucket_name" {
  default = "lion-s3-backend"
  type    = string
}

variable "dynamodb_table" {
  default = "lion-s3-backend_terraform_state_lock"
  type    = string
}
