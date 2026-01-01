####################
# Global / Project
####################
variable "project_name" {
  type = string
}

####################
# Network
####################
variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "rds_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "use_existing_nat_gateway" {
  type    = bool
  default = false
}
####################
# Security Group
####################
variable "app_port" {
  type = number
}

variable "db_port" {
  type = number
}

variable "additional_db_source_sg_ids" {
  description = "A list of additional security group IDs to allow access to the database."
  type        = list(string)
  default     = []
}

####################
# RDS (값만 전달)
####################
variable "db_master_username" {
  type = string
}

variable "db_master_password" {
  type      = string
  sensitive = true
}

####################
# Compute / Launch Template
####################
variable "launch_template_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "user_data_path" {
  type = string
}

variable "enable_monitoring" {
  type = bool
}

variable "metadata_http_endpoint" {
  type = string
}

variable "metadata_http_tokens" {
  type = string
}

variable "metadata_hop_limit" {
  type = number
}

variable "instance_metadata_tags" {
  type = string
}

variable "root_device_name" {
  type = string
}

variable "root_volume_size" {
  type = number
}

variable "root_volume_type" {
  type = string
}

####################
# Auto Scaling Group
####################
variable "asg_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "asg_subnet_ids" {
  type = list(string)
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "health_check_grace_period" {
  type = number
}

variable "target_group_arns" {
  type = list(string)
}

variable "launch_template_id" {
  type = string
}

####################
# Redis
####################
variable "redis_replication_group_id" {
  description = "The ID for the ElastiCache replication group."
  type        = string
}

variable "redis_node_type" {
  description = "The node type for the ElastiCache nodes."
  type        = string
}
