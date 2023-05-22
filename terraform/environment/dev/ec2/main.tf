#--------------------------------------------------------------------------------------------------------------
# EC2                                                                                                         |
#--------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12.18"
  backend "s3" {
    bucket                  = "teste-case-matheus-leao"
    key                     = "dev/ec2/terraform.tfstate.d/terraform.tfstate"
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
  version = "~> 4.0"
  default_tags {
    tags = {
      Environment = "${terraform.workspace}"
      ManagedByTerraform   = "true"
      TEST-CASE = "matheus.leao"
      }
  }
}

module "ec2" {
  source                 = "../../../modules/ec2"
  

  name                   = "matheus-leao-host-k8s"
  instance_count         = 1

  ami                         = "ami-007855ac798b5175e"
  key_name                    = "matheus-leao"
  instance_type               = "t3a.medium"
  monitoring                  = true
  vpc_security_group_ids      = ["sg-0b009b7782c63f428"]
  subnet_id                   = "subnet-03d2fccbe4f97bcf7"
  associate_public_ip_address = true
  user_data                  = "${file("user_data.sh")}"
  

  root_block_device = [{
    volume_type = "gp3"
    volume_size = 20
  }]
}








