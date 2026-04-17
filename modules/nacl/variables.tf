variable "main_vpc_id" {}
variable "satellite_vpc_id" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "clinical_subnet_ids" {
  type = list(string)
}

variable "staff_main_subnet_ids" {
  type = list(string)
}

variable "iot_subnet_ids" {
  type = list(string)
}

variable "patient_subnet_ids" {
  type = list(string)
}

variable "vpn_client_cidr" {}
variable "staff_satellite_cidr" {}
variable "patient_cidr" {}
variable "iot_cidr" {}

variable "tags" {
  type = map(string)
}