data "aws_ami" "amazon_linux2" {
  most_recent = true

  owners = [
    "137112412989"
  ]

  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-gp2"
    ]
  }

  filter {
    name = "architecture"
    values = [
      "x86_64"
    ]
  }

  filter {
    name = "root-device-type"
    values = [
      "ebs"
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }
}
