data "aws_security_group" "default_sg" {
  name   = "default"
  vpc_id = aws_vpc.main.id
}
