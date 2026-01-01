variable "queue_name" {
  type = string
}

variable "visibility_timeout" {
  type    = number
  default = 30
}

variable "message_retention" {
  type    = number
  default = 345600 # 4 days
}

variable "receive_wait_time_seconds" {
  type    = number
  default = 0
}

variable "max_message_size" {
  type    = number
  default = 262144 # 256 KB
}
