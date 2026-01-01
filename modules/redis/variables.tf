variable "replication_group_id" {
  description = "The replication group identifier. This name must be unique for all replication groups owned by this AWS account in the current AWS Region."
  type        = string
}

variable "node_type" {
  description = "The compute and memory capacity of the nodes in the node group (shard)."
  type        = string
  default     = "cache.t3.small"
}

variable "engine_version" {
  description = "The version number of the cache engine to be used for the clusters in this replication group. If you don't specify a value, AWS ElastiCache uses the latest major and minor version of the engine."
  type        = string
  default     = "7.2"
}

variable "port" {
  description = "The port number on which each of the cache nodes will accept connections."
  type        = number
  default     = 6379
}

variable "vpc_id" {
  description = "The ID of the VPC where the Redis cluster will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs for the cache subnet group."
  type        = list(string)
}

variable "source_security_group_id" {
  description = "The security group ID that is allowed to connect to the Redis cluster."
  type        = string
}

variable "num_node_groups" {
  description = "The number of node groups (shards) for this Redis replication group."
  type        = number
  default     = 1
}

variable "replicas_per_node_group" {
  description = "The number of replica nodes in each node group (shard)."
  type        = number
  default     = 1
}

variable "project_name" {
  description = "The name of the project to use for tagging resources."
  type        = string
}
