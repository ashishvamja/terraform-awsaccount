resource "aws_subnet" "subnets" {

  vpc_id                  = aws_vpc.main.id
  for_each                = { for subnet in var.subnets : subnet.subnet_name => subnet }
  cidr_block              = each.value.subnet_cidr
  availability_zone       = each.value.subnet_az
  map_public_ip_on_launch = each.value.subnet_public_access
  tags = merge(local.tags, { Name = each.value.subnet_name })
}