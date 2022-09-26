# Code guide

## AWS 서비스 단위 폴더 구성 및 변수에 \*.tfvars 파일 및 locals 블럭 사용

### 폴더 및 파일 구성

```
.
├── 00_S3
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── state-backend.tf
│   ├── terraform.tfvars
│   └── variables.tf
│
├── 01_VPC
│   ├── internat_gateway.tf
│   ├── local.tf
│   ├── main.tf
│   ├── nat_gateways.tf
│   ├── output.tf
│   ├── planfile
│   ├── provider.tf
│   ├── route_tables.tf
│   ├── security_group.tf
│   ├── subnets.tf
│   ├── terraform.tfvars
│   ├── variable.tf
│   └── vpc.tf
│
├── 02_SG
│   ├── data.tf
│   ├── local.tf
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── security_group.tf
│   ├── security_group_rule.tf
│   ├── terraform.tfvars
│   └── variables.tf
│
├── 03_EC2
│   ├── data.tf
│   ├── ec2.tf
│   ├── local.tf
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variable.tf
│
├── 05_ALB
│   ├── data.tf
│   ├── elb_alb.tf
│   ├── elb_alb_listener.tf
│   ├── elb_alb_tg.tf
│   ├── local.tf
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── variable.tf
│
└── 06_RDS
    ├── data.tf
    ├── local.tf
    ├── main.tf
    ├── output.tf
    ├── parameter_group.tf
    ├── planfile
    ├── provider.tf
    ├── rds_aurora.tf
    ├── subnet_group.tf
    ├── terraform.tfvars
    └── variable.tf
```

---

> **폴더에 추가 생성된 파일**
>
> ```
> .
> ├── local.tf
> └── terraform.tfvars
> ```

---

> **향후 생성 추가 되는 파일**
>
> - terraform init 명령어 적용시 생성 파일
>   - 각각 폴더별 Terraform 실행은 가능하나, 각 폴더당 .terraform 폴더가 생성되어 용량 증가
>
> ```
> .
> ├── .terraform
> │   └── providers
> │  
> └── .terraform.lock.hcl
> ```
>
> - terraform plan 명령어 적용시 생성 파일
>
> ```
> . 
> └── planfile
> ```
>
> - terraform apply 명령어 적용시
>   - S3 생성시 local에 생성
>   - S3 제외 다른 폴더에 있는 리소스는 원격에 생성 (AWS S3 bucket)
>
> ```
> .
> ├── terraform.tfstate
> └── terraform.tfstate.backup
>
> (apply 2회 적용시 생성)
> ```

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
```

```
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
6. variable     block
7. function
8. locals       black
```

> 참고용 URL
>
> - https://www.terraform.io/intro
> - https://www.terraform.io/language
> - https://registry.terraform.io/providers/hashicorp/aws/latest/docs
> - https://www.terraform.io/language/values/locals
> -

---

# S3 Folder

> 폴더 항목
>
> ```
> 00_S3
> ├── main.tf
> ├── outputs.tf
> ├── provider.tf
> ├── state-backend.tf
> ├── terraform.tfvars
> └── variables.tf
> ```

---

> 명령어
>
> ```
> $ cd 00_S3
>
> $ terraform init
> $ terraform plan -refresh=false -out=planfile -var-file=terraform.tfvars
> $ terraform apply planfile
> ```
