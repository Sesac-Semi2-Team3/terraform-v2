resource "aws_rds_cluster_instance" "this" {
  count = var.instance_count

  identifier         = "${var.cluster_identifier}-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.this.id

  instance_class = var.instance_class
  engine         = var.engine
  engine_version = var.engine_version

  publicly_accessible = false
}
