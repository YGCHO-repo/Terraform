resource "aws_vpc" "this" {
  cidr_block = "10.50.0.0/16"
  tags       = { "Name" = "test-tf-vpc" }
}