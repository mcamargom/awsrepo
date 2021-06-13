resource "aws_s3_bucket" "bucket-s3-obligatorio" {
  bucket = "bucket-s3-obligatorio"
  acl    = "private"
# 
  versioning {
    enabled = true
  }
# 
  tags = {
    Name = "First-Bucket-obligatorio"
# 
  }
}
# 
# 