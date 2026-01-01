resource "aws_lb" "this" {
  name               = var.alb_name
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"

  subnets         = var.subnet_ids
  security_groups = var.security_group_ids

  idle_timeout               = 60
  enable_http2               = true
  enable_deletion_protection = false
  drop_invalid_header_fields = false

  desync_mitigation_mode     = "defensive"
  preserve_host_header       = false
  xff_header_processing_mode = "append"
}
