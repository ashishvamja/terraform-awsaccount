resource "tls_private_key" "pvt_key" {

  for_each = toset(var.ssh_key_names)

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  for_each = toset(var.ssh_key_names)

  key_name   = each.value
  public_key = tls_private_key.pvt_key[each.value].public_key_openssh

  depends_on = [
    tls_private_key.pvt_key
  ]

}