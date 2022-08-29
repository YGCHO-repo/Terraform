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
> 폴더 항목
```
 00_S3
 ├── main.tf
 ├── outputs.tf
 ├── provider.tf
 └── state-backend.tf
```
> 명령어
```
$ cd 00_S3

$ terraform init 
$ terraform plan -refresh=false -out=planfile
$ terraform apply planfile
```

-----
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
### state-backend.tf
```hcl
resource "aws_s3_bucket" "this" {
  bucket = "test-terraform-state-backend-yg"
  tags = {Name = "test-terraform-state-backend-yg"}
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    # bucket_key_enabled = 
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "this" {
  name         = "test-terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = { Name = "test-terraform-state-locks" }
}

```
+ **resource "aws_s3_bucket" "this" {...} 블럭 생성 진행**
  - bucket
    - 생성 진행할 bucket 설정

+ **resource "aws_s3_bucket_versioning" "this" {...} 블럭 생성 진행**
  - bucket
    - 위에서 생성한 bucket 설정
  - versioning_configuration
    - Versioning 활성화 여부 확인 내부 블럭
      - "Enabled" 설정

+ **resource "aws_s3_bucket_acl" "this" {...} 블럭 생성 진행**
  - bucket
    - 위에서 생성한 bucket 설정
  - acl
    - bucket의 타입(public / private) 설정
      - "private" 설정
+ **resource "aws_s3_bucket_server_side_encryption_configuration" "this" {...} 블럭 생성 진행**
  - bucket
    - 위에서 생성한 bucket 설정
  - rule
    - apply_server_side_encryption_by_default 서버측 암호화 설정
      - "AES256" 암호화 알고리즘으로 설정
+ **resource "aws_dynamodb_table" "this" {...} 블럭 생성 진행**
  - name
    - 생성 진행할 DynamoDB table name 설정
  - billing_mode
    - 빌링 방법 설정
  - hash_key
    - 해쉬 키값 설정
  - attribute 내부 블럭
    - hash_key의 속성 설정


> 참고용 URL
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table

-----

##  VPC Folder
> 폴더 항목
```
 01_VPC
 ├── internat_gateway.tf
 ├── main.tf
 ├── nat_gateways.tf
 ├── output.tf
 ├── provider.tf
 ├── route_tables.tf
 ├── route_tables_rule.tf
 ├── subnet.tf
 └── vpc.tf
```
> 명령어
```
$ cd 00_VPC

$ terraform init 
$ terraform plan -refresh=false -out=planfile
$ terraform apply planfile
```

-----
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

  backend "s3" {
    bucket         = "test-terraform-state-backend-yg"
    dynamodb_table = "test-terraform-state-locks"
    key            = "vpc/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
  }
}
```
- required_version
  - 실행 위치 디바이스의 테라폼 버전 관련 설정
- required_providers
  - registry.terraform.io/hashicorp/aws 에서 4.22.0 버전 사용

- backend
  - 

