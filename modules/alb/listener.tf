resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type = "forward"

    forward {
      stickiness {
        enabled  = false
        duration = 3600
      }

      target_group {
        arn    = aws_lb_target_group.this.arn
        weight = 1
      }
    }
  }

  lifecycle {
    ignore_changes = [
      default_action[0].target_group_arn
    ]
  }
}
