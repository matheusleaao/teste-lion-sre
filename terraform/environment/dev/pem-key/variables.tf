variable "aws_profile" {
  default = "user-teste-sre"
  description = "Name of the AWS profile who's applying the Terraform"
}

variable "aws_region" {
  default = "us-east-1"
  description = "Region where the database will be hosted"
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "default"
}