region = "ap-northeast-2"

s3_bucket = "test-terraform-state-backend-yg"
s3_acl    = "private"

dynamodb_table = "test-terraform-state-locks"

tags = {
  "CreatedByTerraform" = "true"
  "purpose"            = "TerraformTest"
  "owner"              = "YG"
  "purpose"            = "TEST"
  "resource"           = "backend_S3"
}