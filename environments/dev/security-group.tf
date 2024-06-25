module "security_group" {
  
  source = "../../modules/security-group"

  vpc_name = "${local.env}-demo-vpc"
  security_groups = [
    {
        security_group_name = "${local.env}-demo-vpc-ingress-sg"
        description         = "Security group for nginx instance"
        inbound = [
            {
                port        = "80"
                protocol    = "tcp"
                source      = "0.0.0.0/0"
                description = "Allow HTTP traffic"
            }
        ]
        outbound = [
            {
                port = "0"
                protocol = "-1"
                destination = "0.0.0.0/0"
                description = "Allow all outbound traffic"
            }
        ]
    }
  ]
}