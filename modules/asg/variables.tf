variable "asg_name"            { type = string }
variable "subnet_ids"          { type = list(string) }
variable "min_size"            { type = number }
variable "max_size"            { type = number }
variable "desired_capacity"    { type = number }
variable "target_group_arns"   { type = list(string) }
variable "launch_template_id"  { type = string }
variable "instance_name" {
  type = string
}

variable "health_check_grace_period" {
  type = number
}