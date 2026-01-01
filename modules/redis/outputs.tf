output "replication_group_id" {
  description = "The ID of the ElastiCache Replication Group."
  value       = aws_elasticache_replication_group.this.id
}

output "primary_endpoint_address" {
  description = "The address of the primary endpoint for the ElastiCache Replication Group."
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "reader_endpoint_address" {
  description = "The address of the reader endpoint for the ElastiCache Replication Group."
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
}

output "security_group_id" {
  description = "The ID of the security group created for the Redis cluster."
  value       = aws_security_group.redis.id
}
