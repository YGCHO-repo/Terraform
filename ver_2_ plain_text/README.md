# Code guide

## AWS resource(service) 단위로 *.tf 파일 구성

### 파일 구성
- main.tf
- provider.tf
- vpc.tf
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

> 향후 생성 추가 되는 파일
- terraform plan 명령어 적용시 
    - planfile <plan 적용시 생성되는 파일>
- terraform apply 명령어 적용시
    - terraform.tfstate
    - terraform.tfstate.backup

### 테라폼 명령어
```
실행
$ terraform init 

계획
$ terraform plan -out=planfile

적용
$ terraform apply planfile
```
