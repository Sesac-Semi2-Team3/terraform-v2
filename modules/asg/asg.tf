resource "aws_autoscaling_group" "this" {
  name                = var.asg_name
  vpc_zone_identifier = var.subnet_ids

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  health_check_type         = "ELB"
  health_check_grace_period = 300
  tag {
  key                 = "Name"
  value               = var.instance_name
  propagate_at_launch = true
  }

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  target_group_arns = var.target_group_arns

  termination_policies = [
    "OldestInstance"
  ]

  lifecycle {
    create_before_destroy = true
  }
}
