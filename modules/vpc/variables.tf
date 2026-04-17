variable "main_vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "satellite_vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}