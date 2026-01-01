output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "app_sg_id" {
  value = aws_security_group.app.id
}

output "worker_sg_id" {
  value = aws_security_group.worker.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}