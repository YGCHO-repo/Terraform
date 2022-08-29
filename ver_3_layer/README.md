# Code guide
## AWS resource(서비스) 단위로 폴더 구성

-----
### 폴더 및 파일 구성
```
.
├── 00_S3
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── state-backend.tf
│
├── 01_VPC
│   ├── internat_gateway.tf
│   ├── main.tf
│   ├── nat_gateways.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── route_tables.tf
│   ├── route_tables_rule.tf
│   ├── subnet.tf
│   └── vpc.tf
│
├── 02_SG
│   ├── data.tf
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── security_group.tf
│   └── security_group_rule.tf
│
├── 03_EC2
│   ├── data.tf
│   ├── ec2.tf
│   ├── main.tf
│   ├── output.tf
│   └── provider.tf
│
├── 04_ALB
│   ├── data.tf
│   ├── elb_alb.tf
│   ├── elb_alb_listener.tf
│   ├── elb_alb_listener_rule.tf
│   ├── elb_alb_tg.tf
│   ├── main.tf
│   ├── output.tf
│   └── provider.tf
│
└─── 05_RDS
    ├── data.tf
    ├── main.tf
    ├── output.tf
    ├── provider.tf
    ├── rds_aurora.tf
    ├── rds_aurora_pg.tf
    └── rds_aurora_subnet.tf
```
> **향후 생성 추가 되는 파일**
- terraform plan 명령어 적용시 생성 파일
```
└── planfile
```

- terraform apply 명령어 적용시
  - S3 생성시 local에 생성
  - S3 제외 다른 폴더에 있는 리소스는 원격에 생성 (AWS S3 bucket)
```
├── terraform.tfstate
└── terraform.tfstate.backup (apply 2회 적용시 생성)      
```

-----
### 참고 사항
```
S3 생성은 local backend

나머지는 remote backend
```

-----
### 테라폼 명령어
```
실행
$ terraform init 

계획
$ terraform plan -refresh=false -out=planfile

적용
$ terraform apply planfile

적용 완료시 설정값 확인 (*.tfstate 파일)
$ terraform refresh
$ terraform show
```

-----
### 사용된 리소스 블럭
```
1. terraform    block
2. provider     block
3. resource     block
4. output       block
5. data         block
```

> 참고용 URL  
> >테라폼 구조 관련
- https://www.terraform.io/intro
- https://www.terraform.io/language
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs

-----

## s3 Folder
### main.tf
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
### provider.tf
```hcl
provider "aws" {
  region = "ap-northeast-2"
```
- provider 는 "aws"로 사용, 리전은 "ap-northeast-2" Seoul 리전으로 사용을 설정

-----
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