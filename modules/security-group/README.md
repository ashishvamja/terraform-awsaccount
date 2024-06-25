<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Securitygroups to be created | <pre>list(object({<br>    security_group_name = string<br>    description         = string<br>    inbound = optional(list(object({<br>      port        = string<br>      protocol    = string<br>      source      = string<br>      description = optional(string)<br>    })))<br>    outbound = list(object({<br>      port        = string<br>      protocol    = string<br>      destination = string<br>      description = optional(string)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to add to the resources provisioned by module | `map(string)` | `{}` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC in which security group needs to be created | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->