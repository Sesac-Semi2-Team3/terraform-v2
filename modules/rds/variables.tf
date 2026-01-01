variable "global_cluster_identifier" {
  type = string
}

variable "cluster_identifier" {
  type = string
}

variable "engine" {
  type    = string
  default = "aurora-mysql"
}

variable "engine_version" {
  type = string
}

variable "database_name" {
  type    = string
  default = null
}

variable "master_username" {
  type    = string
  default = null
}

variable "master_password" {
  type    = string
  default = null
}


variable "vpc_security_group_ids" {
  type = list(string)
}

variable "instance_class" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "subnet_ids" {
  type = list(string)
}

variable "is_primary" {
  type = bool
}
