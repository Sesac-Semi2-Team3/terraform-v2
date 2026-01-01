variable "launch_template_name" { type = string }
variable "ami_id"               { type = string }
variable "instance_type"        { type = string }
variable "iam_instance_profile" { type = string }
variable "security_group_ids"   { type = list(string) }
variable "user_data_path"       { type = string }

variable "enable_monitoring" { type = bool }

variable "metadata_http_endpoint" { type = string }
variable "metadata_http_tokens"   { type = string }
variable "metadata_hop_limit"     { type = number }
variable "instance_metadata_tags" { type = string }

variable "root_device_name" { type = string }
variable "root_volume_size" { type = number }
variable "root_volume_type" { type = string }

