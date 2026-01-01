resource "aws_rds_global_cluster" "this" {
  count = var.is_primary ? 1 : 0

  global_cluster_identifier = var.global_cluster_identifier
  engine                   = var.engine
  engine_version            = var.engine_version
}
