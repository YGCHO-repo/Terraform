# Code guide

## AWS resource(service) 단위로 *.tf 파일 구성

-----
### 파일 구성
- main.tf
- provider.tf
- vpc.tf
- subnet.tf
- internat_gateway.tf
- nat_gateways.tf
- route_tables.tf
- route_tables_rule.tf
- security_group.tf
- security_group_rule.tf
- ec2_instances.tf
- elb_alb.tf
- elb_alb_tg.tf
- elb_alb_listener.tf
- elb_alb_listener_rule.tf
- rds_aurora_subnet.tf
- rds_aurora_pg.tf
- rds_aurora.tf
- output.tf
     
     
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

> 참고용 URL 
- https://www.terraform.io/language/resources/syntax
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

-----









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
├── output.tf
└── README.md



