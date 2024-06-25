resource "random_shuffle" "subnet" {
  for_each = { for instance in var.instances : instance.instance_name => instance }

  input        = data.aws_subnets.selected[each.value.instance_name].ids
  result_count = 1
}

resource "aws_instance" "main" {

  for_each = { for instance in var.instances : instance.instance_name => instance }

  ami           = each.value.ami_image == "amazon_linux_2" ? data.aws_ami.amazon_linux_2.id : data.aws_ami.ubuntu_20_04.id
  subnet_id     = random_shuffle.subnet[each.value.instance_name].result[0]
  instance_type = each.value.instance_type

  disable_api_termination = each.value.instance_termination_protection

  user_data_base64 = each.value.userdata_base64

  key_name = each.value.ssh_key

  root_block_device {

    delete_on_termination = each.value.root_block_device_volume.delete_on_termination
    volume_size           = each.value.root_block_device_volume.volume_size
    volume_type           = each.value.root_block_device_volume.volume_type
    #kms_key_id            = try(data.aws_kms_alias.selected[each.value.instance_name].id, null)
    tags = {
      Name = each.value.instance_name
    }
  }

  vpc_security_group_ids = data.aws_security_groups.selected[each.value.instance_name].ids

  tags = merge(local.tags, each.value.tags, { Name = each.value.instance_name })

}