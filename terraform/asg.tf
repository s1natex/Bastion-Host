resource "aws_autoscaling_group" "bastion_asg" {
  name              = "${var.project_name}-bastion-asg"
  desired_capacity  = 1
  min_size          = 1
  max_size          = 1
  health_check_type = "EC2"
  force_delete      = true
  vpc_zone_identifier = [
    aws_subnet.public_subnet.id
  ]

  launch_template {
    id      = aws_launch_template.bastion_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-bastion"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.tags["Project"]
    propagate_at_launch = true
  }
}
