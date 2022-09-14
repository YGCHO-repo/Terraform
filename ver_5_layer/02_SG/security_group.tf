# Default SG Network Disable
resource "aws_default_security_group" "this" {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  tags   = merge(var.tags, tomap({ Name = format("%s-%s-default-sg", var.prefix, var.sg_name) }))
}

# SG 생성을 위한 블럭
resource "aws_security_group" "this" {
    for_each = { for i in local.all_sg : i.name => i  }
    # for_each = { for i in local.all_sg : i.grouping => i  }

    name = format("%s-%s-%s-security-groups", var.prefix, var.sg_name, each.value.name)
    
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    tags = merge(var.tags, tomap({ Name = format("%s-%s-%s-security-group", var.prefix, var.sg_name, each.value.name)}))
}

/* 
for_each 문을 사용하여 생성한 값

aws_security_group.this[bastion].id
aws_security_group.this[web].id
aws_security_group.this[was].id
aws_security_group.this[rds].id
aws_security_group.this[front].id
aws_security_group.this[backend].id
 */