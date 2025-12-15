variable "region" {
  type = string
}

variable "cluster_identifier" {}

variable "engine" {}
variable "engine_version" {}

variable "master_username" {}
variable "master_password" {
  sensitive = true
}

variable "instance_class" {}
variable "instance_count" {
  type = number
}

variable "db_subnet_group_name" {}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}


variable "storage_encrypted" {
  type = bool
}

variable "kms_key_id" {
  default = null
}

variable "deletion_protection" {
  type = bool
}

variable "monitoring_interval" {
  type = number
}

variable "monitoring_role_arn" {}

variable "enabled_cloudwatch_logs_exports" {
  type = list(string)
}

variable "db_cluster_parameter_group_name" {}

variable "instance_identifiers" {
  type = list(string)
}



variable "project_name" {
  type = string
}

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

variable "existing_nat_gateway_id" {
  type = string
}

variable "app_port" {
  description = "Application port"
  type        = number
}

variable "db_port" {
  description = "Database port"
  type        = number
}

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


variable "key_name" {
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

variable "asg_name" {
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

variable "target_group_arns" {
  type = list(string)
}

variable "launch_template_id" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "health_check_grace_period" {
  type = number
}
