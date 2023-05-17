variable "service_name" {
    description = "The name of the service. Used in AWS tagging."
    default     = "QuickSetupSSMForEC2"
}

variable "aws_account_id" {
    description = "The AWS Account ID in which the resources will be deployed into."
    default     = "123456789"
}
