provider "aws" {
  region  = var.region
  profile = "default"
}

# terraform {
#   backend "s3" {
#     bucket         = "terraform-backend-grupo3"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "TerraformCloudLock"
#   }
# }