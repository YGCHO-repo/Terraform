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
│   ├── state-backend.tf
│   └── variables.tf
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