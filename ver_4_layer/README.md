# Code guide
## AWS 서비스 단위 폴더 구성 및 변수/함수 사용

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
      - **```merge```** . **```tomap```** . **```formet```** 함수 사용
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
> $ cd 00_VPC
> 
> $ terraform init 
> $ terraform plan -refresh=false -out=planfile
> $ terraform apply planfile
> ```

-----
> **앞서 설명 드린 내용은 빠르게 Skip 진행하고 추가된 내용 안내 드립니다.**
-----

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
      - **```merge```** . **```tomap```** . **```formet```** 함수 사용
        - **```variable.tf```** 파일에서 생성한 **```prefix```** & **```tags```** & **```vpc_name```** 값 참조
          - 1. ```merge()``` 함수 사용 ```var.tags``` , **```tomap()```** 값 **병합**
          - 2. ```tomap()``` 함수 사용 ```Name``` , **```format()```** 함수 값 리턴
          - 3. ```format()``` 함수 사용 ```var.prefix``` , ```var.vpc_name``` 값 설정


> 참고용 URL
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
> - https://www.terraform.io/language/functions/format
> - https://www.terraform.io/language/functions/tomap
> - https://www.terraform.io/language/functions/merge

-----

## 01_VPC/subnet.tf
```hcl
resource "aws_subnet" "main_pub_a_subnet" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnets.pub_a.cidr
  availability_zone = var.subnets.pub_a.az
  tags              = merge(var.tags, tomap({ Name = format("%s-%s-%s-public-main-subnet", var.prefix, var.vpc_name, var.azs.a_zone)}))
}
resource "aws_subnet" "main_pub_c_subnet" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnets.pub_c.cidr
  availability_zone = var.subnets.pub_c.az
  tags              = merge(var.tags, tomap({ Name = format("%s-%s-%s-public-main-subnet", var.prefix, var.vpc_name, var.azs.c_zone)}))
}
```
+ **resource "aws_subnet" "main_pub_a_subnet" {...} 블럭 생성 진행**
  - cidr_block
    - **```variable.tf```** 파일에서 생성한 **```subnets```** . **```pub_a```** . **```cidr```** 값 참조
      - ```cidr_block = var.subnets.pub_a.cidr```   **or**   ```cidr_block = "10.50.10.0/24"``` 똑같다
  - tag
    - merge(var.tags, tomap({ Name = format("%s-%s-%s-public-main-subnet", var.prefix, var.vpc_name, var.azs.a_zone)}))
      - **```merge```** . **```tomap```** . **```formet```** 함수 사용
        - **```variable.tf```** 파일에서 생성한 **```prefix```** & **```tags```** & **```vpc_name```** & **```vpc_name```** 값 참조
          - 1. ```merge()``` 함수 사용 ```var.tags``` , ```tomap()``` 값 **병합**
          - 2. ```tomap()``` 함수 사용 ```Name``` , **```format()```** 함수 값 리턴
          - 3. ```format()``` 함수 사용 ```var.prefix``` , ```var.vpc_name``` , ```var.azs``` 값 설정

+ **resource "aws_subnet" "main_pub_c_subnet" {...} 블럭 생성 진행**
  - cidr_block
    - **```variable.tf```** 파일에서 생성한 **```subnets```** . **```pub_c```** . **```cidr```** 값 참조
      - ```cidr_block = var.subnets.pub_a.cidr```   **or**   ```cidr_block = "10.50.20.0/24"``` 똑같다
  - tag
    - merge(var.tags, tomap({ Name = format("%s-%s-%s-public-main-subnet", var.prefix, var.vpc_name, var.azs.c_zone)}))
      - **```merge```** . **```tomap```** . **```formet```** 함수 사용
        - **```variable.tf```** 파일에서 생성한 **```prefix```** & **```tags```** & **```vpc_name```** & **```vpc_name```** 값 참조
          - 1. ```merge()``` 함수 사용 ```var.tags``` , ```tomap()``` 값 **병합**
          - 2. ```tomap()``` 함수 사용 ```Name``` , **```format()```** 함수 값 리턴
          - 3. ```format()``` 함수 사용 ```var.prefix``` , ```var.vpc_name``` , ```var.azs``` 값 설정

> 참고용 URL
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
> - https://www.terraform.io/language/functions/format
> - https://www.terraform.io/language/functions/tomap
> - https://www.terraform.io/language/functions/merge

-----
# SG Folder
> 폴더 항목
> ```
> 02_SG
> ├── data.tf
> ├── main.tf
> ├── output.tf
> ├── provider.tf
> ├── security_group.tf
> ├── security_group_rule.tf
> └── variables.tf
> ```

-----
> 명령어
> ```
> $ cd 02_SG
> 
> $ terraform init 
> $ terraform plan -refresh=false -out=planfile
> $ terraform apply planfile
> ```

-----
> **앞서 설명 드린 내용은 빠르게 Skip 진행하고 추가된 내용 안내 드립니다.**
-----
## 02_SG/variable.tf
```hcl
variable "region" {
  type        = string
  default     = "ap-northeast-2"
}

variable "prefix" {
  type        = string
  default     = "test"
}

variable "name" {
  type        = string
  default     = "tf-msc"
}

variable "tags" {
  type        = map(string)
  default = {
    "CreatedByTerraform" = "True"
    "purpose"            = "Test"
    "owner"              = "msc"
    "resource"           = "SG"
  }
}

variable "rules" {
  type        = map(any)
  default = {
    bastion = {
      name        = "bastion"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = []
    },
    web = {
      name        = "web"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = []
    },
    was = {
      name        = "was"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = []
    },
    rds = {
      name        = "rds"
      type        = "ingress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = []
    }
    front = {
      name        = "front"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = []
    }
    backend = {
      name        = "backend"
      type        = "ingress"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = []
    }
  }
}
```
+ **variable "region" {...} 블럭 생성 진행**
+ **variable "prefix" {...} 블럭 생성 진행**
+ **variable "name" {...} 블럭 생성 진행**
+ **variable "tags" {...} 블럭 생성 진행**
+ **variable "rules" {...} 블럭 생성 진행**

-----

## 02_SG/security_group_rule.tf
```hcl
resource "aws_security_group_rule" "bastion_ssh_ingress_rule" {
  description = "SSH - Bastion Server inbound rule"
  type        = var.rules.bastion.type
  from_port   = var.rules.bastion.from_port
  to_port     = var.rules.bastion.to_port
  protocol    = var.rules.bastion.protocol

  security_group_id = aws_security_group.bastion_sg.id

  # SSH 통신 허용 IP 입력
  cidr_blocks = ["211.60.50.190/32"]
}
```
+ **resource "aws_subnet" "main_pub_c_subnet" {...} 블럭 생성 진행**
  - type
    - var.rules.bastion.type
      - **```variable.tf```** 파일에서 생성한 **```rules```** . **```bastion```** . **```type```** 값 참조
  - from_port
    -  var.rules.bastion.from_port
      - **```variable.tf```** 파일에서 생성한 **```rules```** . **```bastion```** . **```from_port```** 값 참조
  - to_port
    - var.rules.bastion.to_port
      - **```variable.tf```** 파일에서 생성한 **```rules```** . **```bastion```** . **```to_port```** 값 참조
  - protocol
    - var.rules.bastion.protocol
      - **```variable.tf```** 파일에서 생성한 **```rules```** . **```bastion```** . **```protocol```** 값 참조

> 참고용 URL
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule

-----
# EC2(Bastion) Folder
> 폴더 항목
> ```
> 03_EC2_bastion
> ├── data.tf
> ├── ec2.tf
> ├── main.tf
> ├── output.tf
> ├── planfile
> ├── provider.tf
> └── variable.tf
> ```

-----
> 명령어
> ```
> $ cd 03_EC2_
> 
> $ terraform init 
> $ terraform plan -refresh=false -out=planfile
> $ terraform apply planfile
> ```

-----
> **앞서 설명 드린 내용은 빠르게 Skip 진행하고 추가된 내용 안내 드립니다.**
-----

## 03_EC2_bastion/data.tf
```hcl
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"
    # values = ["amzn2-ami-hvm*"]
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
}
```
+ **data "aws_ami" "amazon-linux-2" {...} 블럭 생성 진행**
  - most_recent
    - data 블럭/필터 검색시 동일 항목의 경우 최신 버전 사용여부
  - owners
    - data 블럭의 owners 값 설정
    - **_```"amazon"```_** 이 관리 하는 리소스
  - filter
    - 필터링 진행시 필요한 정보 설정
    - Amazon linux 2 AMI 이미지를 찾기 위한 설정

> 참고용 URL
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami
> - https://www.terraform.io/language/data-sources

> 참고용 URL (AWS)
> - https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html

-----

## 03_EC2_bastion/variable.tf
```hcl
variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "prefix" {
  type    = string
  default = "test"
}

variable "az" {
  description = "Created EC2-Bastion AZ"
  type        = string
  default     = "ap-northeast-2a"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "bastion"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key name to use for EC2 instance"
  type        = string
  default     = "tf_test_key"
}

variable "volume_size" {
  description = "The size of the volume in gigabytes"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "The type of volume (gp2, gp3, io2, standard)"
  type        = string
  default     = "gp2"
}

variable "tags" {
  type = map(string)
  default = {
    "CreatedByTerraform" = "True"
    "purpose"            = "Test"
    "owner"              = "msc"
    "resource"           = "EC2"
  }
}
```
+ **variable "region" {...} 블럭 생성 진행**
+ **variable "prefix" {...} 블럭 생성 진행**
+ **variable "az" {...} 블럭 생성 진행**
+ **variable "instance_name" {...} 블럭 생성 진행**
+ **variable "instance_type" {...} 블럭 생성 진행**
+ **variable "key_name" {...} 블럭 생성 진행**
+ **variable "volume_size" {...} 블럭 생성 진행**
+ **variable "volume_type" {...} 블럭 생성 진행**
+ **variable "tags" {...} 블럭 생성 진행**

-----
## 03_EC2_bastion/variable.tf
```hcl
resource "aws_instance" "bastion" {
  ami               = data.aws_ami.amazon-linux-2.id
  availability_zone = var.az
  instance_type     = var.instance_type
  key_name          = var.key_name
  
  subnet_id         = data.terraform_remote_state.vpc.outputs.pub_a_subnet_id
  
  security_groups   = [data.terraform_remote_state.sg.outputs.bastion_sg_id, ]

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
    tags        = merge(var.tags, tomap({ Name = format("%s-tf-%s-%s-ebs", var.prefix, var.az, var.instance_name)}))
  }
  
  lifecycle { create_before_destroy = true }
  
  tags = merge(var.tags, tomap({ Name = format("%s-tf-%s-%s", var.prefix, var.az, var.instance_name)}))
}
```
+ **resource "aws_instance" "bastion" {...} 블럭 생성 진행**
  - ami
    - data.aws_ami.amazon-linux-2.id
      - 위에서 설정한 **```data.tf```** 파일의 **```data  "aws_ami" "amazon-linux-2" {...}```** 블럭 참조
  - availability_zone
    - var.az
      - **```variable.tf```** 파일에서 생성한 **```az```** 값 참조
  - instance_type
    - var.instance_type
      - **```variable.tf```** 파일에서 생성한 **```instance_type```** 값 참조
  - key_name
    - var.key_name
      - **```variable.tf```** 파일에서 생성한 **```key_name```** 값 참조
  - root_block_device ```(내부 블럭)```
    - volume_size
      - var.volume_size
        - **```variable.tf```** 파일에서 생성한 **```volume_size```** 값 참조 
    - volume_type
      - var.volume_type
        - **```variable.tf```** 파일에서 생성한 **```volume_type```** 값 참조 

> 참고용 URL
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami_ids

-----
# EC2(Service) Folder



















# ALB Folder
# RDS Folder

