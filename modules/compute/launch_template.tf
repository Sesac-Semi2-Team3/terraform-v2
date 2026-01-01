resource "aws_launch_template" "this" {
  name          = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  vpc_security_group_ids = var.security_group_ids
  user_data              = filebase64(var.user_data_path)

  monitoring {
    enabled = var.enable_monitoring
  }

  metadata_options {
    http_endpoint               = var.metadata_http_endpoint
    http_tokens                 = var.metadata_http_tokens
    http_put_response_hop_limit = var.metadata_hop_limit
    instance_metadata_tags      = var.instance_metadata_tags
  }

  block_device_mappings {
    device_name = var.root_device_name

    ebs {
      volume_size           = var.root_volume_size
      volume_type           = var.root_volume_type
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.launch_template_name
    }
  }

  lifecycle {
    ignore_changes = [
      tag_specifications
    ]
  }
}
