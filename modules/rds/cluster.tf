resource "aws_rds_cluster" "this" {
  cluster_identifier = var.cluster_identifier

  engine         = var.engine
  engine_version = var.engine_version

  # Primary는 생성, Secondary는 참조
  global_cluster_identifier = var.is_primary ? aws_rds_global_cluster.this[0].id : var.global_cluster_identifier

  database_name   = var.is_primary ? var.database_name : null
  master_username = var.is_primary ? var.master_username : null
  master_password = var.is_primary ? var.master_password : null

  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids

  deletion_protection = var.deletion_protection
  skip_final_snapshot = true

    lifecycle {
    ignore_changes = [
      replication_source_identifier
    ]
  }
}
