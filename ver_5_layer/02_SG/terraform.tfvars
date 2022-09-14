region = "ap-northeast-2"

prefix = "test"

sg_name = "tf-msc"
# sg_name = ["bastion", "web", "was", "rds"]

tags = {
    "CreatedByTerraform" = "True"
    "purpose"            = "Test"
    "owner"              = "Megazone"
    "resource"           = "SG"
}

rules = {
  bastion = {
      keyword                  = "bastion"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0", ]
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "SSH for Bastion server"
    },
    web = {
      keyword                  = "web"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Bastion to WEB"
    },
    was = {
      keyword                  = "was"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Bastion to WAS"
    },
    rds = {
      keyword                  = "rds"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "AWS Aurora RDS"
    },
    front = {
      keyword                  = "front"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Front ALB SG - HTTP"
    },
    front = {
      keyword                  = "front"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Front ALB SG - SSL"
    },
    backend = {
      keyword                  = "backend"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Backend ALB SG"
    },
    backend = {
      keyword                  = "backend"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Backend ALB SG"
    },
    backend = {
      keyword                  = "backend"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 10001
      to_port                  = 11000
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "SG Rule TEST"
    },
    backend = {
      keyword                  = "backend"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 11001
      to_port                  = 12000
      protocol                 = "tcp"
      cidr_blocks              = []
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "SG Rule TEST"
    },
 
}