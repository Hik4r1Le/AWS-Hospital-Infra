variable "main_hospital_vpc_id" {
  type = string
}

variable "satellite_clinic_vpc_id" {
  type = string
}

variable "main_hospital_vpc_cidr_block" {
  type = string
}

variable "satellite_clinic_vpc_cidr_block" {
  type = string
}

variable "main_hospital_igw_id" {
  type = string
}

variable "satellite_clinic_igw_id" {
  type = string
}

variable "main_hospital_ngw_az1_id" {
  type = string
}

variable "main_hospital_ngw_az2_id" {
  type = string
}

variable "satellite_clinic_ngw_id" {
  type = string
}

variable "transit_gateway_id" {
  type = string
}

variable "main_hospital_public_subnet_ids" {
  type = list(string)
}

variable "main_hospital_clinical_subnet_az1_id" {
  type = string
}

variable "main_hospital_clinical_subnet_az2_id" {
  type = string
}

variable "main_hospital_staff_subnet_id" {
  type = string
}

variable "main_hospital_patient_subnet_id" {
  type = string
}

variable "main_hospital_iot_subnet_id" {
  type = string
}

variable "satellite_clinic_public_subnet_id" {
  type = string
}

variable "satellite_clinic_iot_subnet_id" {
  type = string
}

variable "satellite_clinic_staff_subnet_id" {
  type = string
}



