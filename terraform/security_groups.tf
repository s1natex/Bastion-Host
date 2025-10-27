resource "aws_security_group" "bastion_sg" {
  name        = "${var.project_name}-bastion-sg"
  description = "OpenVPN and optional SSH from trusted IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "OpenVPN UDP 1194 from trusted IP"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = [
      var.trusted_cidr
    ]
  }

  ingress {
    description = "SSH break-glass from trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      var.trusted_cidr
    ]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-bastion-sg"
    }
  )
}

resource "aws_security_group" "private_sg" {
  name        = "${var.project_name}-private-sg"
  description = "Allow SSH only from bastion SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from bastion SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      aws_security_group.bastion_sg.id
    ]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-sg"
    }
  )
}
