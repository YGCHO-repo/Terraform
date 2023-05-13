# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#                       Internet G/W 생성
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "test-tf-vpc-igw" }
}