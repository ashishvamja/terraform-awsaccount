resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id
  tags = merge(local.tags, { Name = "${var.internet_gateway_name}" })
}

resource "aws_eip" "nat_eip" {
  for_each = { for nat in var.nat_gateways : nat.nat_gateway_name => nat }

  tags = merge(local.tags, { Name = each.value.nat_gateway_eip_name })

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_nat_gateway" "ngw" {
  for_each      = { for nat in var.nat_gateways : nat.nat_gateway_name => nat }

  allocation_id = aws_eip.nat_eip[each.value.nat_gateway_name].id
  subnet_id     = aws_subnet.subnets[each.value.nat_gateway_subnet].id
  tags = merge(local.tags, { Name = each.value.nat_gateway_name })

  depends_on = [
    aws_subnet.subnets,
    aws_internet_gateway.igw,
    aws_eip.nat_eip
  ]
}