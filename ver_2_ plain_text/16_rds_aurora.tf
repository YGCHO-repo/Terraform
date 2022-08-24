# ++++++++++++++++++++++++++++++++++++++++++++++
#                   RDS 생성 (Standard)
# ++++++++++++++++++++++++++++++++++++++++++++++


# ++++++++++++++++++++++++++++++++++++++++++++++
#                   RDS 생성 (Aurora)
# ++++++++++++++++++++++++++++++++++++++++++++++
resource "aws_rds_cluster" "rds_aurora_cluster" {
  cluster_identifier = "test-tf-rds-aurora-cluster"
  db_subnet_group_name             = aws_db_subnet_group.this.id
  
  engine         = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.02.0"
  
  availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]

  database_name   = "testterraformdb"
  master_username = "admin"
  master_password = "DBAdmin1004"

  port = 3306

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot       = false
  final_snapshot_identifier = false

  backup_retention_period = 1
  # preferred_backup_window = 
  # preferred_maintenance_window = 

  db_cluster_parameter_group_name  = aws_rds_cluster_parameter_group.this.id
  db_instance_parameter_group_name = aws_db_parameter_group.this.id
  
  
  # storage_type      = "gp3"
  # allocated_storage = 100
  # iops              = 1000
}


resource "aws_rds_cluster_instance" "this" {
  # count = length(var.azs)
  count      = 2
  identifier = "test-tf-rds-aurora-${count.index}"
  # identifier_prefix = 
  cluster_identifier = aws_rds_cluster.rds_aurora_cluster.id
  db_subnet_group_name    = aws_db_subnet_group.this.id


  instance_class = "db.t3.medium"

  engine         = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.02.0"
  # engine_version = "5.6.mysql_aurora.1.17.9"
  # engine_version = "5.7.mysql_aurora.2.03.2"

  publicly_accessible = false


  apply_immediately = false

  copy_tags_to_snapshot = false
  
  # lifecycle {
  #   create_before_destroy = true
  #   prevent_destroy = false
  #   ignore_changes = [
  #   ]
  # }

  # availability_zone = "ap-northeast-2a"

  db_parameter_group_name = aws_db_parameter_group.this.id
  
  # tags = 
}