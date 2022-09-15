# Default SG Network Disable
resource "aws_default_security_group" "this" {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  tags   = merge(var.tags, tomap({ Name = format("%s-tf-msc-default-sg", var.prefix) }))
}

// for_each 문을 사용하여 생성한 값
/* 
    aws_security_group.this[bastion].id
    aws_security_group.this[web].id
    aws_security_group.this[was].id
    aws_security_group.this[rds].id
    aws_security_group.this[front].id
    aws_security_group.this[backend].id
 */

resource "aws_security_group" "this" {
  #  count = length(var.sg_name)
    for_each = { for i in local.all_sg : i.name => i  }

    name = format("%s-tf-msc-%s-security-groups", var.prefix, each.value.name)
    
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    # AWS console SG 생성과 같이 Default outbound rule 생성 (All )
    egress { 
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    tags = merge(var.tags, tomap({ Name = format("%s-tf-msc-%s-security-group", var.prefix, each.value.name)}))
}


 resource "aws_security_group_rule" "cidr_ingress" {
    # for_each          = { for i in local.cidr_2_rules_ingress : i.name => i }
    for_each          = { for i in local.all_rules : i.name => i }
    
    security_group_id = aws_security_group.this[each.value.sg_name].id
    type              = each.value.type
    from_port         = each.value.from_port
    to_port           = each.value.to_port
    cidr_blocks       = each.value.cidr_blocks
    ipv6_cidr_blocks  = each.value.ipv6_cidr_blocks
    protocol          = each.value.protocol
    prefix_list_ids   = each.value.prefix_list_ids
    description       = each.value.description


    depends_on = [
        aws_security_group.this
    ] 
}
