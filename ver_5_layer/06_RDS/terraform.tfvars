region = "ap-northeast-2"

prefix = "test"

azs = ["ap-northeast-2a", "ap-northeast-2c"]

rds_name = "rds-aurora"

engine_info = {
  engine          = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.02.0"
}

rds_cluster_identifier = {
    database_name   = "testterraformdb"
    master_username = "admin"
    master_password = "DBAdmin1004"
}

tags = {
    "CreatedByTerraform" = "True"
    "purpose"            = "Test"
    "owner"              = "Megazone"
    "resource"           = "RDS"
}
