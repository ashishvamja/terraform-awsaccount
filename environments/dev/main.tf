module "vpc" {
    source = "../../modules/vpc"
  
    vpc_cidr_block = "10.0.0.0/16"
    vpc_name = "${local.env}-demo-vpc"
    default_security_group_name = "${local.env}-demo-vpc-default-sg"

    internet_gateway_name = "${local.env}-demo-vpc-igw"

    nat_gateways = [
        {
        nat_gateway_name     = "${local.env}-demo-vpc-ngw01"
        nat_gateway_eip_name = "${local.env}-demo-vpc-ngw-eip01"
        nat_gateway_subnet   = "${local.env}-demo-vpc-public-subnet01"
        },
        {
        nat_gateway_name     = "${local.env}-demo-vpc-ngw02"
        nat_gateway_eip_name = "${local.env}-demo-vpc-ngw-eip02"
        nat_gateway_subnet   = "${local.env}-demo-vpc-public-subnet02"
        },
        {
        nat_gateway_name     = "${local.env}-demo-vpc-ngw03"
        nat_gateway_eip_name = "${local.env}-demo-vpc-ngw-eip03"
        nat_gateway_subnet   = "${local.env}-demo-vpc-public-subnet03"
        }
    ]

    route_tables = [
        {
        routetable_name = "public-rt-${local.env}-demo-vpc"
        routetable_number = 01
        route_public = true
        gateway_attachment = "${local.env}-demo-vpc-igw"
        },
        {
        routetable_name = "private01-rt-${local.env}-demo-vpc"
        routetable_number = 01
        route_public = false
        gateway_attachment = "${local.env}-demo-vpc-ngw01"
        },
        {
        routetable_name = "private02-rt-${local.env}-demo-vpc"
        routetable_number = 02
        route_public = false
        gateway_attachment = "${local.env}-demo-vpc-ngw02"
        },
        {
        routetable_name = "private03-rt-${local.env}-demo-vpc"
        routetable_number = 03
        route_public = false
        gateway_attachment = "${local.env}-demo-vpc-ngw03"
        }
    ]

    subnets = [
        {
        subnet_name                 = "${local.env}-demo-vpc-public-subnet01"
        subnet_cidr = "10.0.0.0/20"
        subnet_az = "us-east-1a"
        subnet_public_access = true
        routetable_association_name = "public-rt-${local.env}-demo-vpc"
        },
        {
        subnet_name                 = "${local.env}-demo-vpc-public-subnet02"
        subnet_cidr = "10.0.32.0/20"
        subnet_az = "us-east-1b"
        subnet_public_access = true
        routetable_association_name = "public-rt-${local.env}-demo-vpc"
        },
        {
        subnet_name                 = "${local.env}-demo-vpc-public-subnet03"
        subnet_cidr = "10.0.64.0/20"
        subnet_az = "us-east-1c"
        subnet_public_access = true
        routetable_association_name = "public-rt-${local.env}-demo-vpc"
        },
        {
        subnet_name                 = "${local.env}-demo-vpc-private-subnet01"
        subnet_cidr = "10.0.96.0/20"
        subnet_az = "us-east-1a"
        subnet_public_access = false
        routetable_association_name = "private01-rt-${local.env}-demo-vpc"
        },
        {
        subnet_name                 = "${local.env}-demo-vpc-private-subnet02"
        subnet_cidr = "10.0.128.0/20"
        subnet_az = "us-east-1b"
        subnet_public_access = false
        routetable_association_name = "private02-rt-${local.env}-demo-vpc"
        },
        {
        subnet_name                 = "${local.env}-demo-vpc-private-subnet03"
        subnet_cidr = "10.0.160.0/20"
        subnet_az = "us-east-1c"
        subnet_public_access = false
        routetable_association_name = "private03-rt-${local.env}-demo-vpc"
        }
    ]
}