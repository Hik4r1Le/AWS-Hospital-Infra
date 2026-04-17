variable "main_hospital_clinical_subnets" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "rds_kms_key_id" {
  type = string
}
