locals {
    default_tags = {
        managed_by = "Terraform"
        module = "terraform-vpc"
    }

    tags = merge(local.default_tags,var.tags)
}