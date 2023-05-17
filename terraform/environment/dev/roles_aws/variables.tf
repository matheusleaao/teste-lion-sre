variable "aws_account_id" {
    description = "The AWS Account ID in which the resources will be deployed into."
    default     = "173052502036"
}

variable "service_name" {
    description = "The name of the service. Used in AWS tagging."
    default     = "QuickSetupSSMForEC2"
}

variable "aws_region" {
    description = "The aws region"
    default     = "us-east-1"
}

variable "aws_profile" {
    description = "The aws profile"
    default     = "user-teste-sre"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "ART-EcsTaskExecutionRole"
}

variable "art_ecr_access_role_name" {
  description = "art ecr access role name"
  default = "art_ecr_access_role_name"
}

