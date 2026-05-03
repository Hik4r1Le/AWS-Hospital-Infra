variable "main_vpc_id" {
  type = string
}

# IDs của 3 route tables cần inject S3 prefix list:
# rt-clinical-az1, rt-clinical-az2, rt-staff-main
variable "s3_gateway_route_table_ids" {
  type = list(string)
}

# Subnets đặt SSM Interface Endpoint ENI:
# private-clinical-az1, private-clinical-az2
variable "ssm_subnet_ids" {
  type = list(string)
}

# Security group cho SSM endpoint (allow HTTPS:443 từ sg-ec2-his)
variable "sg_vpce_ssm_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
