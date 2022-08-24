# Code guide

## AWS resource(service) 단위로 *.tf 파일 구성

-----
### 파일 구성
```
.
├── main.tf
├── provider.tf
├── vpc.tf
├── subnet.tf
├── internat_gateway.tf
├── nat_gateways.tf
├── route_tables.tf
├── route_tables_rule.tf
├── security_group.tf
├── security_group_rule.tf
├── ec2_instances.tf
├── elb_alb.tf
├── elb_alb_tg.tf
├── elb_alb_listener.tf
├── elb_alb_listener_rule.tf
├── rds_aurora_subnet.tf
├── rds_aurora_pg.tf
├── rds_aurora.tf
└── output.tf
```
     
     
> **향후 생성 추가 되는 파일**
- terraform plan 명령어 적용시 생성 파일
    - planfile      

- terraform apply 명령어 적용시
    - terraform.tfstate
    - terraform.tfstate.backup      

-----
### 테라폼 명령어
```
실행
$ terraform init 

계획
$ terraform plan -out=planfile

적용
$ terraform apply planfile
```

-----
### 사용된 리소스 블럭
```
1. terraform    block
2. provider     block
3. resource     block
4. output       block
```

> 참고용 URL  
> >테라폼 구조 관련
- https://www.terraform.io/intro

-----
## main.tf
### terraform 블럭
```hcl
terraform {
  required_version = ">= 1.2.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}
```
- required_version
    - 실행 위치 디바이스의 테라폼 버전 관련 설정

- required_providers
    - registry.terraform.io/hashicorp/aws 에서 4.22.0 버전 사용

-----
## provider.tf
### provider 블럭
```hcl
providre "aws" {
    region = "ap-northeat-2"
}
```
- provider 는 "aws"로 사용, 리전은 "ap-northeast-2" Seoul 리전으로 사용을 선언

----- 
## vpc.tf
### resource vpc 블럭
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
## subnet.tf
### resource subnet 블럭
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
## internet_gateway.tf
### resource igw(internet gateway) 블럭
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
## nat_gateway.tf
### resource natgw(nat gateway) 블럭
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
- NAT Gateway 의 경우 Public 으로 생성 진행
- Public으로 생성시 EIP가 필요하여 EIP 설정후 대상 NAT Gateway에 Attach

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
