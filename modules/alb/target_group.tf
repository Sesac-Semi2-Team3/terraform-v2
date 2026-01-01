resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  target_type      = "instance"
  protocol_version = "HTTP1"

  health_check {
    enabled             = true
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
    path                = "/health"
    protocol            = "HTTP"
    port                = "traffic-port"
  }

  stickiness {
    type            = "lb_cookie"
    enabled         = false
    cookie_duration = 86400
  }
}
