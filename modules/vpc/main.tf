resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags = merge(local.tags, { Name = "${var.vpc_name}" })
}

resource "aws_ec2_tag" "tag_default_sg" {

  resource_id = data.aws_security_group.default_sg.id
  key         = "Name"
  value       = var.default_security_group_name
}

resource "aws_route_table" "routes" {

  for_each = { for route in var.route_tables : route.routetable_name => route }
  vpc_id   = aws_vpc.main.id

  tags = merge(local.tags,{
    Name    = each.value.routetable_name
    Network = each.value.route_public ? "Public${each.value.routetable_number}" : "Private${each.value.routetable_number}"
  })
}

resource "aws_route" "gateway" {

  for_each = { for route in var.route_tables : route.routetable_name => route }

  route_table_id         = aws_route_table.routes[each.value.routetable_name].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = each.value.route_public ? aws_internet_gateway.igw.id : aws_nat_gateway.ngw[each.value.gateway_attachment].id

  depends_on = [
    aws_route_table.routes,
    aws_internet_gateway.igw,
    aws_nat_gateway.ngw
  ]
}

resource "aws_route_table_association" "rt_association" {

  for_each = { for association in var.subnets : association.subnet_name => association }

  route_table_id = aws_route_table.routes[each.value.routetable_association_name].id
  subnet_id      = aws_subnet.subnets[each.value.subnet_name].id

  depends_on = [
    aws_subnet.subnets,
    aws_route_table.routes
  ]
}