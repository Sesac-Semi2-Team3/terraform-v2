# Security Group for Redis
resource "aws_security_group" "redis" {
  name        = "${var.project_name}-redis-sg"
  description = "Security group for Redis cluster, allowing access from the application security group."
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.port
    to_port         = var.port
    protocol        = "tcp"
    security_groups = [var.source_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-redis-sg"
  }
}

# ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.project_name}-redis-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-redis-subnet-group"
  }
}

# ElastiCache Parameter Group
resource "aws_elasticache_parameter_group" "this" {
  name        = "redis7"
  family      = "redis7"
  description = "Managed by Terraform"
}

# ElastiCache Replication Group
resource "aws_elasticache_replication_group" "this" {
  replication_group_id = var.replication_group_id
  description          = "Replication group for ${var.project_name}"

  engine         = "redis"
  engine_version = "7.0"

  node_type = var.node_type

  num_node_groups             = 1
  replicas_per_node_group     = 1
  automatic_failover_enabled  = true
  multi_az_enabled            = true

  parameter_group_name = aws_elasticache_parameter_group.this.name
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  security_group_ids   = [aws_security_group.redis.id]

  port = var.port

  tags = {
    Name = var.replication_group_id
  }
}
