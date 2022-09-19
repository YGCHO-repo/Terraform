resource "aws_eip" "this" {
  for_each = { for i in local.eip_instance : i.name => i }

  vpc = each.value.eip
  instance   = aws_instance.this[each.value.name].id

  tags = merge(var.tags, tomap({ Name = format("%s-tf-%s-%s-eip", var.prefix, each.value.availability_zone, each.value.instance_name) }))
}




resource "aws_instance" "this" {

  for_each = { for i in local.all_instance : i.name => i }

  ami               = data.aws_ami.amazon-linux-2.id
  availability_zone = each.value.availability_zone
  instance_type     = each.value.instance_type
  key_name          = each.value.key_name

  security_groups   = [each.value.security_groups]
  subnet_id         = each.value.subnet_id

  # security_groups   = [each.value.security_groups]
  # security_groups   = [data.terraform_remote_state.sg.outputs.security_groups.bastion.id ]
  # security_groups   = [data.terraform_remote_state.sg.outputs.bastion.id ]
  # subnet_id         = data.terraform_remote_state.vpc.outputs[each.value.subnet_cidr]
  # subnet_id         = format("data.terraform_remote_state.vpc.outputs.subnets.%s.id", each.value.subnet_id)
  # subnet_id         = each.value.subnet_id
  # subnet_id         = data.terraform_remote_state.vpc.outputs.subnets.10.50.10.0/24.id

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = each.value.volume_type

    tags = merge(var.tags, tomap({ Name = format("%s-tf-%s-%s-ebs", var.prefix, each.value.availability_zone, each.value.instance_name) }))
  }
  lifecycle { create_before_destroy = true }

  tags = merge(var.tags, tomap({ Name = format("%s-tf-%s-%s", var.prefix, each.value.availability_zone, each.value.instance_name) }))
}
