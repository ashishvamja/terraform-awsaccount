variable "security_groups" {
  type = list(object({
    security_group_name = string
    description         = string
    inbound = optional(list(object({
      port        = string
      protocol    = string
      source      = string
      description = optional(string)
    })))
    outbound = list(object({
      port        = string
      protocol    = string
      destination = string
      description = optional(string)
    }))
  }))
  description = "Securitygroups to be created"
}

variable "tags" {
  type        = map(string)
  description = "tags to add to the resources provisioned by module"
  default     = {}
}

variable "vpc_name" {
  type        = string
  description = "VPC in which security group needs to be created"
}
