resource "aws_instance" "private_host" {
  ami           = data.aws_ami.amazon_linux2.id
  instance_type = var.instance_type_private
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [
    aws_security_group.private_sg.id
  ]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.generated_key.key_name

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-host"
    }
  )
}
