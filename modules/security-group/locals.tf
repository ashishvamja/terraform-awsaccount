locals {
    default_tags = {
        managed_by = "Terraform"
        module = "terraform-security-group"
    }

    tags = merge(local.default_tags,var.tags)
}