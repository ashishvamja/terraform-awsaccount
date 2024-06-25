module "ec2" {
  
  source = "../../modules/ec2"

  vpc_name = "${local.env}-demo-vpc"

  ssh_key_names = ["${local.env}-demo-keypair"]

  instances = [
    {
        instance_name = "${local.env}-demo-nginx"
        instance_type = "t2.micro"
        instance_subnet = ["${local.env}-demo-vpc-public-subnet01","${local.env}-demo-vpc-public-subnet02"]
        instance_security_groups = ["${local.env}-demo-vpc-ingress-sg"]
        ami_image = "amazon_linux_2"
        #kms_key_name = "custom/ebs"
        root_block_device_volume = {
            delete_on_termination = true
            volume_size           = 8
            volume_type           = "gp2"
        }
        ssh_key = "${local.env}-demo-keypair"
        instance_termination_protection = false
    }
  ]
}