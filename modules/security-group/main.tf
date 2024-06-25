resource "aws_security_group" "main" {

  for_each = { for security_group in var.security_groups : security_group.security_group_name => security_group }

  name        = each.value.security_group_name
  description = each.value.description

  vpc_id = data.aws_vpc.selected.id

  dynamic "ingress" {
    for_each = each.value.inbound != null ? { for inbound in each.value.inbound : inbound.port => inbound } : {}
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.source]
      description = lookup(ingress.value, "description", null)
    }
  }

  dynamic "egress" {
    for_each = { for outbound in each.value.outbound : outbound.port => outbound }
    content {
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.destination]
      description = lookup(egress.value, "description", null)
    }
  }

  tags = merge(local.tags, { Name = each.value.security_group_name })

}
