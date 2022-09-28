# Code guide

## AWS resource(서비스) 단위로 폴더 구성

---

### 폴더 및 파일 구성

```
.
├── 00_S3
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   └── state-backend.tf
│
├── 01_VPC
│   ├── internat_gateway.tf
│   ├── main.tf
│   ├── nat_gateways.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── route_table.tf
│   ├── route_table_rule.tf
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

---

### 참고 사항

```
S3 생성은 local backend
- terraform.tfstate (local에 생성)

VPC/EC2/SG/RDS는 remote backend
- terraform.tfstate (AWS S3에 생성)
```

---

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

---

### 사용된 리소스 블럭

```
1. terraform    block
2. provider     block
3. resource     block
4. output       block
5. data         block
```

> 참고용 URL

- https://www.terraform.io/intro
- https://www.terraform.io/language
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs

---

## S3 Folder

> 폴더 항목

```
 00_S3
 ├── main.tf
 ├── output.tf
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

---

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

---

### provider.tf

```hcl
provider "aws" {
  region = "ap-northeast-2"
```

- provider 는 "aws"로 사용, 리전은 "ap-northeast-2" Seoul 리전으로 사용을 설정

---

### state-backend.tf

```hcl
resource "aws_s3_bucket" "this" {
  bucket = "test-terraform-state-backend-msc"
  tags = {Name = "test-terraform-state-backend-msc"}
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

- **resource "aws_s3_bucket" "this" {...} 블럭 생성 진행**

  - bucket
    - 생성 진행할 bucket 설정

- **resource "aws_s3_bucket_versioning" "this" {...} 블럭 생성 진행**

  - bucket
    - 위에서 생성한 bucket 설정
  - versioning_configuration
    - Versioning 활성화 여부 확인 내부 블럭
      - "Enabled" 설정

- **resource "aws_s3_bucket_acl" "this" {...} 블럭 생성 진행**
  - bucket
    - 위에서 생성한 bucket 설정
  - acl
    - bucket의 타입(public / private) 설정
      - "private" 설정
- **resource "aws_s3_bucket_server_side_encryption_configuration" "this" {...} 블럭 생성 진행**
  - bucket
    - 위에서 생성한 bucket 설정
  - rule
    - apply_server_side_encryption_by_default 서버측 암호화 설정
      - "AES256" 암호화 알고리즘으로 설정
- **resource "aws_dynamodb_table" "this" {...} 블럭 생성 진행**
  - name
    - 생성 진행할 DynamoDB table name 설정
  - billing_mode
    - 빌링 방법 설정
  - hash_key
    - 해쉬 키값 설정
  - attribute 내부 블럭
    - hash_key의 속성 설정

> **S3 bucket as backend**
>
> - Terraform의 상태(terraform.tfstate)파일을 versioning하며 저장하기 위해 S3 bucket을 생성

> **DynamoDB Table for Lock**
>
> - 동시에 같은 파일을 수정하지 못하도록 하기 위해 DynamoDB에 작업에 대한 Lock을 생성

> 참고용 URL

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table

---

## VPC Folder

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
$ cd 01_VPC

$ terraform init
$ terraform plan -refresh=false -out=planfile
$ terraform apply planfile
```

---

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
    bucket         = "test-terraform-state-backend-msc"  # 어떠한 S3 bucket
    dynamodb_table = "test-terraform-state-locks"       # 어떠한 Dynamo DB table
    key            = "vpc/terraform.tfstate"            # 어디 S3 위치의 파일
    region         = "ap-northeast-2"                   # 어디 Region(지역)
    encrypt        = true                               # encrypt 사용 여부
  }
}
```

- required_version
  - 실행 위치 디바이스의 테라폼 버전 관련 설정
- required_providers

  - registry.terraform.io/hashicorp/aws 에서 4.22.0 버전 사용

- **backend**
  - bucket
    - 설정하고자 하는 S3 bucket 이름 설정
  - dynamodb_table
    - 활용하고자 하는 dynamodb 테이블 설정
  - key
    - S3 bucket의 위치/파일명을 설정
  - region
    - S3 bucket의 지역명(리전)을 설정
  - encrypt
    - encrypt 사용 여부 설정

> **Backend 설정을 하면?**
>
> 1.  위에서 생성한 S3 bucket을 활용하여 backend 설정 한다
> 2.  해당 설정을 진행하면 Local에 terraform.tfstate 이 생성되지 않는다
> 3.  terraform.tfstate 파일은 remote 위치인 AWS S3에 생성 된다.

> 참고용 URL

- https://www.terraform.io/language/state/remote-state-data
- https://www.terraform.io/language/settings
- https://www.terraform.io/language/settings/backends/s3
- https://www.terraform.io/language/settings/backends/configuration

---

### output.tf

```hcl
output "vpc_id" {
  value = aws_vpc.this.id
}

output "pub_a_subnet_id" {
  value = aws_subnet.main_pub_a_subnet.id
}
output "pub_c_subnet_id" {
  value = aws_subnet.main_pub_c_subnet.id
}

output "web_a_subnet_id" {
  value = aws_subnet.web_pri_a_subnet.id
}
output "web_c_subnet_id" {
  value = aws_subnet.web_pri_c_subnet.id
}

output "was_a_subnet_id" {
  value = aws_subnet.was_pri_a_subnet.id
}
output "was_c_subnet_id" {
  value = aws_subnet.was_pri_c_subnet.id
}

output "rds_a_subnet_id" {
  value = aws_subnet.rds_pri_a_subnet.id
}
output "rds_c_subnet_id" {
  value = aws_subnet.rds_pri_c_subnet.id
}

output "natgw_a_id" {
  value = aws_nat_gateway.natgw_a.id
}
output "natgw_c_id" {
  value = aws_nat_gateway.natgw_c.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}
```

- **output "vpc_id" {...} 블럭 생성 진행**

  - value
    - aws_vpc.this.id
      - vpc.tf 파일 **resource "aws_vpc" "this" {...} 블럭** 에서 생성된 정보중 id 값을 **output**에 기록

- **output "pub_a_subnet_id" {...} 블럭 생성 진행**

  - value - aws_subnet.main_pub_a_subnet.id - subnet.tf 파일 **resource "aws_subnet" "main_pub_a_subnet" {...} 블럭** 에서 생성된 정보중 id 값을 **output**에 기록
    > ...(동일 파일 내용 생략)

- **output "natgw_a_id" {...} 블럭 생성 진행**

  - value - aws_nat_gateway.natgw_a.id - nat_gateway.tf 파일 **resource "aws_nat_gateway" "natgw_a" {...} 블럭** 에서 생성된 정보중 id 값을 **output**에 기록
    > ...(동일 파일 내용 생략)

- **output "igw_id" {...} 블럭 생성 진행**
  - value
    - aws_internet_gateway.this.id
      - intetnet_gateway.tf 파일 **resource "aws_internet_gateway" "this" {...} 블럭** 에서 생성된 정보중 id 값을 **output**에 기록

> 참고용 URL

- https://www.terraform.io/language/values/outputs
- https://www.terraform.io/language/state/remote
- https://www.terraform.io/language/state/remote-state-data

### vpc.tf

```hcl
resource "aws_vpc" "this" {
  cidr_block = "10.50.0.0/16"
  tags       = { "Name" = "test-tf-vpc" }
}
```

- **resource "aws_vpc" "this" {...} 블럭 생성 진행**
  - cidr_block
    - "10.50.0.0/16"
  - tags
    - { "Name" = "test-tf-vpc" }
      - 기본 Name Tag 설정

> 참고용 URL

- https://www.terraform.io/language/resources/syntax
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

---

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

- **resource "aws_subnet" "main_pub_a_subnet" {...} 블럭 생성 진행**
  - vpc_id
    - aws*vpc*.this.id
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

---

### internet_gateway.tf

```hcl
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "test-tf-vpc-igw" }
}
```

- **resource "aws_internet_gateway" "this" {...} 블럭 생성 진행**
  - vpc_id
    - aws_vpc.this.id
  - tags
    - { Name = "test-tf-vpc-igw" }

> **위의 예제와 같이 설정된 "aws_vpc" "this"를 vpc_id 식별자에 표현값으로 참조 하거나, tags 처럼 사용자가 직접 설정 하여 Code를 작성한다.**

> 참고용 URL

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

---

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

- **resource "aws_eip" "natgw_a_eip" {...} 블럭 생성 진행**

  - 해당 블럭의 내용중 lifecycle은 resource 블럭의 Meta-Arguments 값이다.
    - 기존에 EIP가 존재하다고 가정하면, 기존 EIP를 유지한 상태에서 신규로 생성 및 연결후 기존 EIP를 제거 설정 구문

- **resource "aws_nat_gateway" "natgw_a" {...} 블럭 생성 진행**
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

---

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

- **resource "aws_route_table" "pub_a_main_rtb" {...} 블럭 생성 진행**

  - vpc_id
    - 위에서 생성한 VPC 정보값 참조 설정

- **resource "aws_route_table_association" "pub_a_main_rtb" {...} 블럭 생성 진행**
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

---

---

## SG Folder

> 폴더 항목

```
 02_SG
 ├── data.tf
 ├── main.tf
 ├── output.tf
 ├── provider.tf
 ├── security_group.tf
 └── security_group_rule.tf
```

> 명령어

```
$ cd 02_SG

$ terraform init
$ terraform plan -refresh=false -out=planfile
$ terraform apply planfile
```

---

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
    bucket         = "test-terraform-state-backend-msc"
    dynamodb_table = "test-terraform-state-locks"
    key            = "sg/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
  }
}
```

- **backend**
  - key
    - S3 bucket의 위치/파일명을 설정
      - test-terraform-state-backend-msc/sg/terraform.tfstate
        - "test-terraform-state-backend-msc" S3 bucket의 "sg" 폴더에 "terraform.tfstate" 파일 저장

> 참고용 URL

- https://www.terraform.io/language/state/remote-state-data
- https://www.terraform.io/language/settings
- https://www.terraform.io/language/settings/backends/s3
- https://www.terraform.io/language/settings/backends/configuration

---

### data.tf

```hcl
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "test-terraform-state-backend-msc"
    key    = "vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
```

- **data "terraform_remote_state" "vpc" {...} 블럭 생성 진행**
  - backend
    - 백엔드는 S3로 설정
  - config
    - 백엔드의 설정값을 설정
    - 설정용 내부 블럭
      - bucket
        - 참고하고자 하는 S3를 설정
      - key
        - 참고하고자 하는 S3의 key값 설정
          - 위에서 생성항 01_vpc 폴더의 \*.tf 파일들의 생성값(output)값
          - 생성된 정보값은 **_terraform.tfstate_** 파일 참고
      - region
        - S3 bucket의 지역명(리전)을 설정

---

### security_group.tf

```hcl
resource "aws_security_group" "bastion_sg" {
  description = "Bastion Server Security group"
  name        = "Bastion-SG"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

   egress {
    description = "SSH Outbound Port"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0", "10.50.0.0/16"]
  }
  tags = { Name = "test-tf-msc-bastion-sg" }
}
```

- **resource "aws_security_group" "bastion_sg" {...} 블럭 생성 진행**

  - description
    - 생성하고자 하는 SG의 설명문 항목
  - name

    - 생성하고자 하는 SG의 이름 항목

  - vpc_id
    - 생성하고자 하는 SG의 생성 영역 VPC기준
    - SG의 경우 각각 VPC에 종속 되는 리소스

* SG 블럭에서의 내부 블럭을 2개 작성, 1개 적용으로 작성 하였다.
  - 내부 블럭에서 ingress , egress 는 SG의 inbound , outbound 와 동일하다.
    - ingress -> inbound
    - egress -> outbound
* egress
  - description
    - 해당 SG의 inbound rule 의 설명문
  - protocol
    - "-1"
      - 전체 프로토콜에 대해서 가능하게 설정
      - "-1" 은 전체 프로토콜 범위를 뜻함
  - (해당 rule을 설정시 Outbound는 전체 허용)
  - from_port
    - 포트 설정 : 어디서부터 (시작점)
  - to_port
    - 포트 설정 : 어디까지 (종료점)
  - cidr_blocks
    - **[ ]** 리스트 형식으로 입력
    - "0.0.0.0/0" 전체 IP 영역

> 참고용 URL

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

---

### output.tf