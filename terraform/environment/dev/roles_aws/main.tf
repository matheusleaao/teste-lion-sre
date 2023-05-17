terraform {
  required_version = ">= 0.12.18"
  backend "s3" {
    bucket                  = "lion-s3-backend"
    key                     = "dev/ssm_role/terraform.tfstate.d/terraform.tfstate"
    region                  = "us-east-1"
    encrypt                 = true
    dynamodb_table          = "lion-s3-backend_terraform_state_lock"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "user-teste-sre"
  }
}

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = var.aws_profile
  default_tags {
    tags = { 
          Environment = "${terraform.workspace}"
          ManagedByTerraform   = "true"
      }
  }
}

# IAM Role SSM access
module "ssm_role" {
  source = "../../../modules/ssm_role"

  service_name = var.service_name
  aws_account_id = var.aws_account_id
}
