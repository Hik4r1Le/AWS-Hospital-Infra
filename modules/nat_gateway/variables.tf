variable "public_az1_subnet_id" {}
variable "public_az2_subnet_id" {}
variable "satellite_public_subnet_id" {}

variable "eip_nat_main_az1_id" {}
variable "eip_nat_main_az2_id" {}
variable "eip_nat_satellite_id" {}

variable "main_igw_id" {}
variable "satellite_igw_id" {}

variable "tags" {
  type = map(string)
}