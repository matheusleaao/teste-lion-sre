terraform {
  required_version = ">= 0.12.18"
  backend "s3" {
    bucket                  = "teste-case-matheus-leao"
    key                     = "dev/ecr/terraform.tfstate.d/terraform.tfstate"
    region                  = "us-east-1"
    encrypt                 = true
    dynamodb_table          = "test-case-matheus-leao_terraform_state_lock"
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
          TEST-CASE = "matheus.leao"
      }
  }
}

module "ecr" {
    source = "../../../modules/ecr"
    name = "${var.project}-ecr-${terraform.workspace}"
}