variable "main_hospital_vpc_id" {
  type = string
}

variable "ec2_app_ids" {
  type = list(string)
}

variable "alb_security_group_ids" {
  type = list(string)
}

variable "alb_subnet_ids" {
  type = list(string)
}



