

### vpc.tf
```hcl
resource "aws_vpc" "this" {
  cidr_block = "10.50.0.0/16"
  tags       = { "Name" = "test-tf-vpc" }
}
```
+ **resource "aws_vpc" "this" {...} 블럭 생성 진행**
  - cidr_block
      - "10.50.0.0/16"
  - tags
      - { "Name" = "test-tf-vpc" }
          - 기본 Name Tag 설정

> 참고용 URL 
- https://www.terraform.io/language/resources/syntax
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

-----
### subnet.tf
```hcl
resource "aws_subnet" "main_pub_a_subnet" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.50.10.0/24"
  availability_zone = "ap-northeast-2a"
  tags              = { Name = "test-tf-ap-northeast-2a-public-main-subnet" }
}

...(생략) (필요한 갯수 만큼 설정)
```
+ **resource "aws_subnet" "main_pub_a_subnet" {...} 블럭 생성 진행**
  - vpc_id
      - aws_vpc_.this.id
      - 바로 위에 설정한 "resouce" "aws_vpc" "this" 의 코드 블럭(생성된 정보값)의 id 값을 참조하도록 설정
  - cidr_block
      - "10.50.10.0/24"
  - availability_zone
      - "ap-northeast-2a"
  - tags
      - { Name = "test-tf-ap-northeast-2a-public-main-subnet" }
          - 기본 Name Tag 설정

> 참고용 URL 
- https://www.terraform.io/language/resources/syntax
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

-----
### internet_gateway.tf
```hcl
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "test-tf-vpc-igw" }
}
```
+ **resource "aws_internet_gateway" "this" {...} 블럭 생성 진행**
  - vpc_id
      - aws_vpc.this.id
  - tags
      - { Name = "test-tf-vpc-igw" }

> **위의 예제와 같이 설정된 "aws_vpc" "this"를 vpc_id 식별자에 표현값으로 참조 하거나, tags 처럼 사용자가 직접 설정 하여 Code를 작성한다.**

> 참고용 URL 
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

-----
### nat_gateway.tf
```hcl
# EIP 생성
resource "aws_eip" "natgw_a_eip" {
  vpc = true
  lifecycle { create_before_destroy = true }
  tags = { Name = "test-tf-vpc-ap-northeast-2a-nat-eip" }
}

# NAT G/W 생성
resource "aws_nat_gateway" "natgw_a" {
  allocation_id     = aws_eip.natgw_a_eip.id
  subnet_id         = aws_subnet.main_pub_a_subnet.id
  connectivity_type = "public"
  depends_on        = [aws_eip.natgw_a_eip]
  tags              = { Name = "test-tf-vpc-ap-northeast-2a-main-natgw" }
}
...(생략) (필요한 갯수 만큼 설정)
```
> **NAT Gateway 의 경우 Public 으로 생성 진행 Public으로 생성시 EIP가 필요하여 EIP 설정후 대상 NAT Gateway에 Attach**

+ **resource "aws_eip" "natgw_a_eip" {...} 블럭 생성 진행**
  - 해당 블럭의 내용중 lifecycle은 resource 블럭의 Meta-Arguments 값이다. 
    - 기존에 EIP가 존재하다고 가정하면, 기존 EIP를 유지한 상태에서 신규로 생성 및 연결후 기존 EIP를 제거 설정 구문

+ **resource "aws_nat_gateway" "natgw_a" {...} 블럭 생성 진행**
  - allocation_id
    - 생성된 EIP 연결 설정
  - subnet_id
    - 위에서 생성한 Subnet 연결 설정
  - connectivity_type
    - NAT G/W의 통신 방식 설정
  - depends_on
    - 명시적으로 [aws_eip.natgw_a_eip] 생성이 정상적으로 이뤄진 후, 해당 리소스가 생성 되로록 설정

> 참고용 URL 
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway

-----
### route_table.tf
```hcl
# RTB 생성
resource "aws_route_table" "pub_a_main_rtb" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "test-tf-vpc-ap-northeast-2a-public-main-rtb" }
}

# RTB to Subnet association 
resource "aws_route_table_association" "pub_a_main_rtb" {
  route_table_id = aws_route_table.pub_a_main_rtb.id
  subnet_id      = aws_subnet.main_pub_a_subnet.id
  # gateway_id = aws_internet_gateway.this.id
}
...(생략) (필요한 갯수 만큼 설정)
```
+ **resource "aws_route_table" "pub_a_main_rtb" {...} 블럭 생성 진행**
  - vpc_id
    - 위에서 생성한 VPC 정보값 참조 설정

+ **resource "aws_route_table_association" "pub_a_main_rtb" {...} 블럭 생성 진행**
  - route_table_id
    - 생성된 RTB 의 id 참조하여 설정
  - subnet_id
    - 생성된 서브넷 의 id 참조하여 설정
  - gateway_id
    - IGW 및 NAT 연결 가능한 식별자 설정을 보여주고자 작성
    - 해당 항목은 subnet_id 와 중복하여 설정 불가.

> 참고용 URL 
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

-----