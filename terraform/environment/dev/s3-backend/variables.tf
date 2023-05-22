variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "aws_profile" {
  default = "user-teste-sre"
  type    = string
}

variable "bucket_name" {
  default = "teste-case-matheus-leao"
  type    = string
}

variable "dynamodb_table" {
  default = "test-case-matheus-leao_terraform_state_lock"
  type    = string
}
