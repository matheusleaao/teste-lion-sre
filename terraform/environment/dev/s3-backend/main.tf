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


module "s3" {
  source         = "../../../modules/s3"
  bucket_name    = var.bucket_name
  dynamodb_table = var.dynamodb_table
  versioning     = true
}
