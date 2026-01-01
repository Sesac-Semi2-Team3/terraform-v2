variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "app_port" {
  description = "Application port"
  type        = number
}

variable "db_port" {
  description = "Database port"
  type        = number
}

variable "additional_db_source_sg_ids" {
  description = "A list of additional security group IDs to allow access to the database."
  type        = list(string)
  default     = []
}
