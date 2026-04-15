variable "main_hospital_vpc_id" {
  type = string
}

variable "satellite_clinic_vpc_id" {
  type = string
}

variable "main_hospital_subnet_ids" {
  type = list(string)
}

variable "satellite_clinic_subnet_ids" {
  type = list(string)
}
