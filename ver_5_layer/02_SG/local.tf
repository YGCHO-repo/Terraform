# locals {
#   all_sg = toset(flatten([
#     for key, value in var.rules : {
#       name                         = key
#       keyword                     = value.keyword
#       security_group_id           = value.security_group_id
#       type                        = value.type
#       from_port                   = value.from_port
#       to_port                     = value.to_port
#       protocol                    = value.protocol
#       cidr_blocks                 = value.cidr_blocks
#       source_security_group_id    = value.source_security_group_id
#       ipv6_cidr_blocks            = value.ipv6_cidr_blocks
#       prefix_list_ids             = value.prefix_list_ids
#       self                        = value.self
#       description                 = value.description
#     }
#   ])
#   )
# }


# SG 생성 을위한 SG 전체 key값 기준
locals {
  all_sg = flatten([
    for key, value in var.rules : {
      name                        = key
      grouping                     = value.grouping
      security_group_id           = value.security_group_id
      type                        = value.type
      from_port                   = value.from_port
      to_port                     = value.to_port
      protocol                    = value.protocol
      cidr_blocks                 = value.cidr_blocks
      source_security_group_id    = value.source_security_group_id
      ipv6_cidr_blocks            = value.ipv6_cidr_blocks
      prefix_list_ids             = value.prefix_list_ids
      self                        = value.self
      description                 = value.description
    }
  ])
}

locals {
  all_sg = flatten([
    for key, value in var.rules : {
      name                        = key
      grouping                     = value.grouping
      security_group_id           = value.security_group_id
      type                        = value.type
      from_port                   = value.from_port
      to_port                     = value.to_port
      protocol                    = value.protocol
      cidr_blocks                 = value.cidr_blocks
      source_security_group_id    = value.source_security_group_id
      ipv6_cidr_blocks            = value.ipv6_cidr_blocks
      prefix_list_ids             = value.prefix_list_ids
      self                        = value.self
      description                 = value.description
    }
    # if (( 0 < length(value.cidr_blocks)  || 0 < length(value.ipv6_cidr_blocks) || 0 < length(value.prefix_list_ids)) && false == value.self && "ingress" == value.type )
  ])
}


# locals {
#   cidr_2_rules_ingress = flatten([
#     for key, value in var.rules : {
#       name             = key
#       type             = value.type
#       from_port        = value.from_port
#       to_port          = value.to_port
#       protocol         = value.protocol
#       cidr_blocks      = value.cidr_blocks
#       ipv6_cidr_blocks = value.ipv6_cidr_blocks
#       prefix_list_ids  = value.prefix_list_ids
#       description      = value.description  
#     }
#     if (( 0 < length(value.cidr_blocks)  || 0 < length(value.ipv6_cidr_blocks) || 0 < length(value.prefix_list_ids)) && false == value.self && "ingress" == value.type )
#   ])
# }

# locals {
#   cidr_2_rules_egress = flatten([
#     for key, value in var.rules : {
#       name             = key
#       type             = value.type
#       from_port        = value.from_port
#       to_port          = value.to_port
#       protocol         = value.protocol
#       cidr_blocks      = value.cidr_blocks
#       ipv6_cidr_blocks = value.ipv6_cidr_blocks
#       prefix_list_ids  = value.prefix_list_ids
#       description      = value.description  
#     }
#     if (( 0 < length(value.cidr_blocks)  || 0 < length(value.ipv6_cidr_blocks) || 0 < length(value.prefix_list_ids)) && false == value.self && "egress" == value.type )
#   ])
# }

# locals {
#    self_2_rules_ingress = flatten([
#     for key, value in var.rules : {
#       name             = key
#       type             = value.type
#       from_port        = value.from_port
#       to_port          = value.to_port
#       protocol         = value.protocol
#       prefix_list_ids  = value.prefix_list_ids
#       description      = value.description
#       self             = value.self  
#     } 
#     if ( true == value.self && "ingress" == value.type )
#    ])
# }

# locals {
#    self_2_rules_egress = flatten([
#     for key, value in var.rules : {
#       name             = key
#       type             = value.type
#       from_port        = value.from_port
#       to_port          = value.to_port
#       protocol         = value.protocol
#       prefix_list_ids  = value.prefix_list_ids
#       description      = value.description  
#       self             = value.self 
#     } 
#     if ( true == value.self && "egress" == value.type )
#    ])
# }

# locals {
#     sg_2_rules_ingress = flatten([
#     for key, value in var.rules : {
#         name                     = key
#         type                     = value.type
#         from_port                = value.from_port
#         to_port                  = value.to_port
#         protocol                 = value.protocol
#         source_security_group_id = value.source_security_group_id
#         prefix_list_ids          = value.prefix_list_ids
#         description              = value.description
#     }
#     if ( "" != value.source_security_group_id  && false == value.self && "ingress" == value.type )
#     ]) 
# }

# locals {
#     sg_2_rules_egress = flatten([
#     for key, value in var.rules : {
#         name                     = key
#         type                     = value.type
#         from_port                = value.from_port
#         to_port                  = value.to_port
#         protocol                 = value.protocol
#         source_security_group_id = value.source_security_group_id
#         prefix_list_ids          = value.prefix_list_ids
#         description              = value.description
#     }
#     if ( "" != value.source_security_group_id  && false == value.self && "egress" == value.type )
#     ]) 
# }