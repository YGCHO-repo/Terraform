# Code guide 
## main.tf 파일 하나로 code 되어 있음.

### 파일 구성
1. main.tf 


### 테라폼 명령어 
```
실행
$ terraform init 

계획
$ terraform plan

적용
$ terraform apply
```

### 사용된 리소스 블럭
```
1. terraform    block
2. provider     block
3. resource     block
```

- 테라폼 구조 관련 URL
    - https://www.terraform.io/intro

## 사전 준비
- Terraform Command 실행을 위한 디바이스 환경 설정
  - terraform 설치 
  - VS code 와 같은 texteditor(IDE) 설치
  - AWS CLI 설치 및 credentials(AK / SK) 설정 


## main.tf 
#### terraform 블럭
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
        - 

- required_providers
    - registry.terraform.io/hashicorp/aws 에서 4.22.0 버전 사용

### provider 블럭
```hcl

providre "aws" {
    region = "ap-northeat-2"
}
```
- provider 는 "aws" 로 사용 , 리전은 "ap-northeast-2" KR 리전으로 사용 을 선언

### resource 블럭
- resource 블럭은 실제 AWS 에 존재하는 서비스를 생성/삭제 등과 같은 액션을 가능 하도록 하는 블럭

#### resource 블럭의 구조
```hcl
resource "aws_vpc" "this" {
  cidr_block = "10.50.0.0/16"
}

<BLOCK TYPE> "<BLOCK LABEL_1>" "<BLOCK LABEL_2>" {
    <IDENTIFIER> = <EXPRESSION>
}
```

#### resource vpc 블럭
```hcl
resource "aws_vpc" "this" {
  cidr_block = "10.50.0.0/16"
  tags       = { "Name" = "test-tf-vpc" }
}
```
- 블럭 타입은 "resource", 블럭 라벨 1은 "aws_vpc" , 블럭 라벨 2는 "this"
    - 블럭 라벨 2는 Code 작성자가 임의로 설정 가능하다.

- 식별자는 2개가, 표현값도 2개 설정 되어 있다. 
    - 식별자 
        - cidr_block
        - tags
    - 표현값
        - "10.50.0.0/16"
        - { "Name" = "test-tf-vpc" }

#### resource subnet 블럭
```hcl
resource "aws_subnet" "main_pub_a_subnet" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.50.10.0/24"
  availability_zone = "ap-northeast-2a"
  tags              = { Name = "test-tf-ap-northeast-2a-public-main-subnet" }
}

...(생략) (필요한 서브넷의 갯수 만큼 설정)
```
- 블럭 타입은 "resource", 블럭 라벨 1은 "aws_subnet" , 블럭 라벨 2는 "main_pub_a_subnet"
- 식별자는 4개, 표현값도 4개로 구성 되어 있다.
    - 식별자 
        - vpc_id
        - cidr_block
        - availability_zone
        - tags
    - 표현값
        - aws_vpc_.this.id
            - 바로 위에 설정한 "resouce" "aws_vpc" "this" 의 코드 블럭(생성된 정보값)의 id 값을 참조하도록 설정
        - "10.50.10.0/24"
        - "ap-northeast-2a"
        - { Name = "test-tf-ap-northeast-2a-public-main-subnet" }

#### resource igw(internet gateway)
```hcl
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "test-tf-vpc-igw" }
}
```
- 블럭 타입은 "resource", 블럭 라벨 1은 "aws_internet_gateway" , 블럭 라벨 2는 "this"
- 식별자 및 표현값은 각각 2개
    - 식별자 
        - vpc_id
        - tags
    - 표현값
        - aws_vpc.this.id
        - { Name = "test-tf-vpc-igw" }

> 위의 예제와 같이 설정된 "aws_vpc" "this"를 vpc_id 식별자에 표현값으로 참조 하거나, tags 처럼 사용자가 직접 설정 하여 Code를 작성한다.

