#--------------------------------------------------------------------------------------------------------------
# EC2                                                                                                         |
#--------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12.18"
  backend "s3" {
    bucket                  = "TEST-CASE-matheus-leao"
    key                     = "dev/ec2/terraform.tfstate.d/terraform.tfstate"
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

module "ec2" {
  source                 = "../../../modules/ec2"
  

  name                   = "host-k8s"
  instance_count         = 1

  ami                         = "ami-007855ac798b5175e"
  instance_type               = "t2.micro"
  key_name                    = "host-k8s"
  monitoring                  = true
  vpc_security_group_ids      = ["sg-04c0c2bfc7ca398a9"]
  subnet_id                   = "subnet-0c71e9483a9c1aaa0"
  associate_public_ip_address = true
  user_data                  = "${file("user_data.sh")}"
  

  root_block_device = [{
    volume_type = "gp3"
    volume_size = 20
  }]
}








