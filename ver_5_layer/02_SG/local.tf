locals {
  all_sg = flatten([
    for key in var.sg_name : {
      name = key
    }
  ])
}

locals {
  all_rules = flatten([
    for key, value in var.rules : {
      name                        = key
      sg_name                     = value.sg_name
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
    if (( 0 < length(value.cidr_blocks)  || 0 < length(value.ipv6_cidr_blocks) || 0 < length(value.prefix_list_ids)) && false == value.self )
  ])
}