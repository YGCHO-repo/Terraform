data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "test-terraform-state-backend-yg"
    key    = "vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
