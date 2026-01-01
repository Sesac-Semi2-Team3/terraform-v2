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

variable "use_existing_nat_gateway" {
  type = bool
}

variable "existing_nat_gateway_id" {
  type    = string
  default = null
}
