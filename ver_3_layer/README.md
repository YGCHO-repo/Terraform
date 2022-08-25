# Code guide

## AWS resource(서비스) 단위로 폴더 구성

### 폴더 구성
```
.
├── 00_S3
│   └── *.tf
│
├── 01_VPC
│   └── *.tf
│
├── 02_SG
│   └── *.tf
│
├── 03_EC2
│   └── *.tf
│
├── 04_ALB
│   └── *.tf
│
└─── 05_RDS
     └── *.tf
```

-----
### 파일 구성
```
.
├── 00_S3
│   ├── main.tf
│   ├── outputs.tf
│   ├── planfile
│   ├── provider.tf
│   ├── state-backend.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── terraform.tfvars
│   └── variables.tf
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
├── 02_SG
│   ├── data.tf
│   ├── main.tf
│   ├── output.tf
│   ├── planfile
│   ├── provider.tf
│   ├── security_group.tf
│   └── security_group_rule.tf
├── 03_EC2
│   ├── data.tf
│   ├── ec2.tf
│   ├── main.tf
│   ├── output.tf
│   ├── planfile
│   └── provider.tf
├── 04_ALB
│   ├── data.tf
│   ├── elb_alb.tf
│   ├── elb_alb_listener.tf
│   ├── elb_alb_listener_rule.tf
│   ├── elb_alb_tg.tf
│   ├── main.tf
│   ├── output.tf
│   ├── planfile
│   └── provider.tf
└─── 05_RDS
    ├── data.tf
    ├── main.tf
    ├── output.tf
    ├── planfile
    ├── provider.tf
    ├── rds_aurora.tf
    ├── rds_aurora_pg.tf
    └── rds_aurora_subnet.tf
```

-----


