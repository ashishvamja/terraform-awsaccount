variable "instances" {
  type = list(object({
    instance_name            = string
    instance_type            = string
    instance_subnet          = list(string)
    instance_security_groups = list(string)
    ami_image                = string
    kms_key_name             = optional(string)
    root_block_device_volume = map(string)
    userdata_base64          = optional(string)
    ssh_key                         = string
    instance_termination_protection = bool
    tags                            = optional(map(string))
  }))
}

variable "ssh_key_names" {
  type        = list(string)
  description = "SSH key details"
}

variable "vpc_name" {
  type        = string
  description = "VPC in which EC2 instance will be created"
}

