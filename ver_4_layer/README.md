# Code guide
## AWS resource(서비스) 단위 폴더 구성 및 변수/함수 사용

-----
### 폴더 및 파일 구성
```
.
├── 00_S3
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── state-backend.tf
│   └── variables.tf
│
├── 01_VPC
│   ├── internat_gateway.tf
│   ├── main.tf
│   ├── nat_gateways.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── route_tables.tf
│   ├── route_tables_rule.tf
│   ├── subnets.tf
│   ├── variable.tf
│   └── vpc.tf
│
├── 02_SG
│   ├── data.tf
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── security_group.tf
│   ├── security_group_rule.tf
│   └── variables.tf
│
├── 03_EC2_bastion
│   ├── data.tf
│   ├── ec2.tf
│   ├── main.tf
│   ├── output.tf
│   ├── planfile
│   ├── provider.tf
│   └── variable.tf
│
├── 04_EC2_service
│   ├── data.tf
│   ├── ec2.tf
│   ├── main.tf
│   ├── output.tf
│   ├── planfile
│   ├── provider.tf
│   └── variable.tf
│
├── 05_ALB
│   ├── data.tf
│   ├── elb_alb.tf
│   ├── elb_alb_listener.tf
│   ├── elb_alb_listener_rule.tf
│   ├── elb_alb_tg.tf
│   ├── main.tf
│   ├── output.tf
│   ├── planfile
│   ├── provider.tf
│   └── variable.tf
│
└── 06_RDS
    ├── data.tf
    ├── main.tf
    ├── output.tf
    ├── parameter_group.tf
    ├── provider.tf
    ├── rds_aurora.tf
    ├── subnet_group.tf
    └── variable.tf
```

> **향후 생성 추가 되는 파일**
> - terraform init 명령어 적용시 생성 파일
>   - 각각 폴더별 Terraform 실행은 가능하나, 각 폴더당 .terraform 폴더가 생성되어 용량 증가
> ```
> ├── .terraform
> │   └── providers
> │  
> └── .terraform.lock.hcl
> ```
> 
> - terraform plan 명령어 적용시 생성 파일
> ```
> │  
> └── planfile
> ```
> 
> - terraform apply 명령어 적용시
>   - S3 생성시 local에 생성
>   - S3 제외 다른 폴더에 있는 리소스는 원격에 생성 (AWS S3 bucket)
> ```
> ├── terraform.tfstate
> └── terraform.tfstate.backup 
> 
> (apply 2회 적용시 생성)      
> ```

-----
### 참고 사항
```
S3 생성은 local backend
- terraform.tfstate (local에 생성)

VPC/EC2/SG/RDS는 remote backend
- terraform.tfstate (AWS S3에 생성)
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
```

```
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
6. variable     block
7. function     
```

> 참고용 URL
> - https://www.terraform.io/intro
> - https://www.terraform.io/language
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs

-----
# S3 Folder
> 폴더 항목
> ```
> 00_S3
> ├── main.tf
> ├── outputs.tf
> ├── provider.tf
> ├── state-backend.tf
> └── variables.tf
> ```
-----
> 명령어
> ```
> $ cd 00_S3
> 
> $ terraform init 
> $ terraform plan -refresh=false -out=planfile
> $ terraform apply planfile
> ```

-----
> **앞서 설명 드린 내용은 빠르게 Skip 진행하고 추가된 내용 안내 드립니다.**

## 00_S3/variable.tf
```hcl
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "s3_bucket" {
  description = "S3 bucket for terraform-state-backend"
  type        = string
  default     = "test-terraform-state-backend-msc"
}

variable "s3_acl" {
  description = "ACL of S3 Bucket"
  type        = string
  default     = "private"
}

variable "dynamodb_table" {
  description = "DynamoDB table for terraform-state-backend"
  type        = string
  default     = "test-terraform-state-locks"
}

variable "tags" {
  description = "tag map"
  type        = map(string)
  default = {
    "CreatedByTerraform" = "true"
    "purpose"            = "TerraformTest"
    "owner"              = "MSC"
    "purpose"            = "TEST"
    "resource"           = "backend_S3"
  }
}
```
+ **variable "region" {...} 블럭 생성 진행**
  - description
    - 변수의 목적을 간단하게 작성
  - type
    - 변수의 타입을 설정
      - **```string```, ```number```, ```bool```, ```list(TYPE)```, ```map(TYPE)```** 등 있음
  - default
    - 폴더 내부에서 **_```" var.region "```_**을 설정시 적용될 내용
    - **_```"ap-northeast-2"```_** 설정

+ **variable "s3_bucket" {...} 블럭 생성 진행**
  - default
    - 폴더 내부에서 **_```" var.s3_bucket "```_**을 설정시 적용될 내용
    - **_```"test-terraform-state-backend-msc"```_** 설정

+ **variable "s3_acl" {...} 블럭 생성 진행**
  - default
    - 폴더 내부에서 **_```" var.s3_acl "```_**을 설정시 적용될 내용
    - **_```"private"```_** 설정

+ **variable "dynamodb_table" {...} 블럭 생성 진행**
  - default
    - 폴더 내부에서 **_```" var.dynamodb_table "```_**을 설정시 적용될 내용
    - **_```"test-terraform-state-locks"```_** 설정

+ **variable "tags" {...} 블럭 생성 진행**
  - type
    - 변수의 타입을 설정
      - **```map(string)```** 설정
      - **```Key``` =  ```value```** 설정
  - default
    - 폴더 내부에서 **_```" var.tags "```_**을 설정시 적용될 내용
    - 

> 참고용 URL
> - https://www.terraform.io/language/values/variables

-----
## 00_S3/provider.tf
```hcl
provider "aws" {
  region = var.region
}
```
+ **provider "aws" {...} 블럭 진행**
  - region
    - var.region
      - **```variable.tf```** 파일에서 생성한 **```region```** 값 참조
      - ```region = var.region```   **or**   ```region = "ap-northeast-2"``` 똑같다


> 참고용 URL
> - https://www.terraform.io/language/providers/configuration
> - https://www.terraform.io/language/providers/requirements
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs

-----
## 00_S3/state-backend.tf
```hcl
resource "aws_s3_bucket" "terraform_state_backend" {
  bucket = var.s3_bucket

  tags = merge(var.tags, tomap({ Name = format("%s", var.s3_bucket) }))
}


resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.terraform_state_backend.id
  
  acl    = var.s3_acl
}


resource "aws_dynamodb_table" "terraform_state_locks" {
  name         = var.dynamodb_table
  
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(var.tags, tomap({ Name = format("%s", var.dynamodb_table) }))
}
```
+ **resource "aws_s3_bucket" "terraform_state_backend" {...} 블럭 생성 진행**
  - bucket
    - var.s3_bucket
      - **```variable.tf```** 파일에서 생성한 **```s3_bucket```** 값 참조
      
        - ```region = var.s3_bucket```   **or**   ```region = "test-terraform-state-backend-msc"``` 똑같다
  - tag
    - merge(var.tags, tomap({ Name = format("%s", var.s3_bucket) }))
      - **```merge```**, **```tomap```**, **```formet```** 함수 사용
        - **```variable.tf```** 파일에서 생성한 **```s3_bucket```** & **```tags```** 값 참조
          - 1. ```format()``` 함수 사용 ```s3_bucket```의 값을 ```"test-terraform-state-backend-msc"```로 리턴
          - 2. ```tomap()``` 함수 사용 ```Name``` , ```format()``` 리턴
          - 3. ```merge()``` 함수 사용 ```var.tags``` , ```var.s3_bucket``` **병합**

+ **resource "aws_s3_bucket_acl" "this" {...} 블럭 생성 진행**
  - acl
    - var.s3_acl
      - **```variable.tf```** 파일에서 생성한 **```s3_acl```** 값 참조

+ **resource "aws_dynamodb_table" "terraform_state_backend" {...} 블럭 생성 진행**
  - name
    - var.dynamodb_table
      - **```variable.tf```** 파일에서 생성한 **```dynamodb_table```** 값 참조

> **S3 bucket as backend**
>  - Terraform의 상태(terraform.tfstate)파일을 versioning하며 저장하기 위해 S3 bucket을 생성

> **DynamoDB Table for Lock**
>  - 동시에 같은 파일을 수정하지 못하도록 하기 위해 DynamoDB에 작업에 대한 Lock을 생성

> 참고용 URL 
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
> - aws_s3_bucket_acl
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table

> - https://www.terraform.io/language/functions/merge
> - https://www.terraform.io/language/functions/tomap
> - https://www.terraform.io/language/functions/format

-----
# VPC Folder
> 폴더 항목
> ```
> 00_S3
> ├── main.tf
> ├── outputs.tf
> ├── provider.tf
> ├── state-backend.tf
> └── variables.tf

> 01_VPC
> ├── internat_gateway.tf
> ├── main.tf
> ├── nat_gateways.tf
> ├── output.tf
> ├── provider.tf
> ├── route_tables.tf
> ├── route_tables_rule.tf
> ├── subnets.tf
> ├── variable.tf
> └── vpc.tf
> ```

-----
> 명령어
> ```
> $ cd 00_S3
> 
> $ terraform init 
> $ terraform plan -refresh=false -out=planfile
> $ terraform apply planfile
> ```

-----
> **앞서 설명 드린 내용은 빠르게 Skip 진행하고 추가된 내용 안내 드립니다.**

## 01_VPC/variable.tf
```hcl
variable "region" {
  type        = string
  default     = "ap-northeast-2"
}

variable "prefix" {
  type        = string
  default     = "test"
}

variable "azs" {
  type        = map(string)
  default     = {
    a_zone = "ap-northeast-2a"
    c_zone = "ap-northeast-2c"
  }
}

variable "vpc_name" {
  type        = string
  default     = "tf-vpc"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.50.0.0/16"
}

variable "subnets" {
  type = map(any)
  default = {
    "pub_a" = {
      cidr = "10.50.10.0/24"
      az = "ap-northeast-2a"
    },
    "pub_c" = {
      cidr = "10.50.20.0/24"
      az = "ap-northeast-2c"
    },
    "web_a" = {
      cidr = "10.50.110.0/24"
      az = "ap-northeast-2a"
    },
    "web_c" = {
      cidr = "10.50.120.0/24"
      az = "ap-northeast-2c"
    },
    "was_a" = {
      cidr = "10.50.130.0/24"
      az = "ap-northeast-2a"
    },
    "was_c" = {
      cidr = "10.50.140.0/24"
      az = "ap-northeast-2c"
    },
    "rds_a" = {
      cidr = "10.50.210.0/24"
      az = "ap-northeast-2a"
    },
    "rds_c" = {
      cidr = "10.50.220.0/24"
      az = "ap-northeast-2c"
    }
  }
}

variable "tags" {
  type        = map(string)
  default = {
    "CreatedByTerraform" = "True"
    "purpose"            = "Test"
    "owner"              = "MSC"
    "resource"           = "VPC"
  }
}
```
+ **variable "region" {...} 블럭 생성 진행**
+ **variable "prefix" {...} 블럭 생성 진행**
+ **variable "azs" {...} 블럭 생성 진행**
+ **variable "vpc_name" {...} 블럭 생성 진행**
+ **variable "vpc_cidr" {...} 블럭 생성 진행**
+ **variable "subnets" {...} 블럭 생성 진행**
+ **variable "tag" {...} 블럭 생성 진행**


> 참고용 URL
> - https://www.terraform.io/language/values/variables

-----
## 01_VPC/vpc.tf
```hcl
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
    
  tags = merge(var.tags, tomap({Name = format("%s-%s",  var.prefix, var.vpc_name)}))
}
```
+ **resource "aws_vpc" "this" {...} 블럭 생성 진행**
  - cidr_block
    - var.vpc_cidr
      - **```variable.tf```** 파일에서 생성한 **```vpc_cidr```** 값 참조
        - ```cidr_block = var.vpc_cidr```   **or**   ```cidr_block = "10.50.0.0/16""``` 똑같다
  - tag
    - merge(var.tags, tomap({Name = format("%s-%s",  var.prefix, var.vpc_name)}))
      - **```merge```**, **```tomap```**, **```formet```** 함수 사용
        - **```variable.tf```** 파일에서 생성한 **```prefix```** & **```tags```** & **```vpc_name```** 값 참조
          - 1. ```format()``` 함수 사용 ```var.prefix``` , ```var.vpc_name``` 값 설정
          - 2. ```tomap()``` 함수 사용 ```Name``` , **```format()```** 함수 값 리턴
          - 3. ```merge()``` 함수 사용 ```var.tags``` 값과 ```tomap()``` 값을 **병합**






















# SG Folder
# EC2(Bastion) Folder
# EC2(Service) Folder
# ALB Folder
# RDS Folder

