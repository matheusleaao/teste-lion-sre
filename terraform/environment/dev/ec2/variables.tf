variable "aws_profile" {
  default = "user-teste-sre"
  description = "Name of the AWS profile who's applying the Terraform"
}

variable "aws_region" {
  default = "us-east-1"
  description = "Region where the database will be hosted"
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}