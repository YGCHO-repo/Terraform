region = "ap-northeast-2"

prefix = "test"

# sg_name = "tf-msc"
# sg_name = ["bastion", "web", "was", "rds"]

tags = {
    "CreatedByTerraform" = "True"
    "purpose"            = "Test"
    "owner"              = "Megazone"
    "resource"           = "SG"
}

sg_name = {
    bastion = "bastion"
    web =  "web"
    was =  "was"
    rds =  "rds"
    front = "front"
    backend = "backend"
}


rules = {
  bastion = {
      sg_name                  = "bastion"
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
      sg_name                  = "web"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = ["10.50.0.0/16", ]
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Bastion to WEB"
    },

    web_80 = {
      sg_name                  = "web"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      cidr_blocks              = ["10.50.0.0/16", ]
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Bastion to WEB"
    },

    was = {
      sg_name                  = "was"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      cidr_blocks              = ["10.50.0.0/16", ]
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Bastion to WAS"
    },

    was_8080 = {
      sg_name                  = "was"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      cidr_blocks              = ["10.50.0.0/16", ]
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Bastion to WAS"
    },

    rds = {
      sg_name                  = "rds"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      cidr_blocks              = ["10.50.0.0/16", ]
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "AWS Aurora RDS"
    },

    front = {
      sg_name                  = "front"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      cidr_blocks              = ["10.50.0.0/16", ]
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Front ALB SG - HTTP"
    },

    backend = {
      sg_name                  = "backend"
      security_group_id        = ""
      type                     = "ingress"
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      cidr_blocks              = ["10.50.0.0/16", ]
      source_security_group_id = ""
      ipv6_cidr_blocks         = []
      prefix_list_ids          = []
      self                     = false
      description              = "Backend ALB SG"
    },
}