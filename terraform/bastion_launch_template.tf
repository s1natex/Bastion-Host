resource "aws_eip" "bastion_eip" {
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-bastion-eip"
    }
  )
}

data "template_file" "bastion_user_data" {
  template = file("${path.module}/user_data.sh.tftpl")

  vars = {
    region                   = var.region
    eip_alloc_id             = aws_eip.bastion_eip.allocation_id
    bucket                   = aws_s3_bucket.openvpn_bucket.bucket
    vpc_net                  = cidrhost(var.private_subnet_cidr, 0)
    vpc_mask                 = cidrnetmask(var.private_subnet_cidr)
    push_routes              = ""
    simultaneous_connections = ""
  }
}

resource "aws_launch_template" "bastion_lt" {
  name_prefix   = "${var.project_name}-bastion-"
  image_id      = data.aws_ami.amazon_linux2.id
  instance_type = var.instance_type_bastion

  key_name = aws_key_pair.generated_key.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.bastion_instance_profile.name
  }

  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]

  user_data = base64encode(data.template_file.bastion_user_data.rendered)

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "${var.project_name}-bastion"
      }
    )
  }

  lifecycle {
    create_before_destroy = true
  }
}
