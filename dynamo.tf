resource "aws_dynamodb_table" "dynamodb_terraform_cloud_lock" {
  name         = "TerraformCloudLock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "Terraform state lock table for cloud common"
    App     = "TerraformCloudLock"
    Service = "TerraformCloudLock"

  }
} 