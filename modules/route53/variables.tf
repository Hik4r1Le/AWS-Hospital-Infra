variable "main_vpc_id" {
  type = string
}

variable "private_domain_name" {
  type    = string
  default = "hospital.internal"
}

variable "alb_dns_name" {
  type = string
}

variable "alb_zone_id" {
  type = string
}

variable "rds_endpoint" {
  type = string
}

variable "tags" {
  type = map(string)
}
