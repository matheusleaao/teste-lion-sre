terraform {
  required_version = ">= 0.12.18"
  backend "s3" {
    bucket                  = "TEST-CASE-matheus-leao"
    key                     = "dev/pem/terraform.tfstate.d/terraform.tfstate"
    region                  = "us-east-1"
    encrypt                 = true
    dynamodb_table          = "TEST-CASE-matheus-leao_terraform_state_lock"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "user-teste-sre"
  }
}

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = var.aws_profile
  version = "~> 4.0"
  default_tags {
    tags = {
      Environment = "${terraform.workspace}"
      ManagedByTerraform   = "true"
      TEST-CASE = "matheus.leao"
      }
  }
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.private_key.private_key_pem}' > ./matheus-leao.pem"
  }
}