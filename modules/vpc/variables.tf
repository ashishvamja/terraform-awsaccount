variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC"
  default     = false
}

variable "default_security_group_name" {
  type        = string
  description = "VPC Default Security Name"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "enable/disable DNS hostnames in the VPC"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support in the VPC"
  default     = true
}

variable "internet_gateway_name" {
  type        = string
  description = "Name of the Internet Gateway"
}

variable "nat_gateways" {
  type = list(object({
    nat_gateway_name     = string
    nat_gateway_eip_name = string
    nat_gateway_subnet   = string
  }))
  description = "Nat Gateway details"
}

variable "route_tables" {
  type = list(object({
    routetable_name    = string
    route_public       = bool
    routetable_number  = string
    gateway_attachment = string
  }))
  description = "RouteTable details"
}

variable "subnets" {
  type = list(object({
    subnet_name                 = string
    subnet_cidr                 = string
    subnet_az                   = string
    subnet_public_access        = bool
    routetable_association_name = string
  }))
  description = "Subnet details"
}

variable "tags" {
  type        = map(string)
  description = "tags to add to the resources provisioned by module"
  default     = {}
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  description = "Name of the VPC to set"
  type        = string
}
