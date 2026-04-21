variable "main_vpc_id" {}
variable "satellite_vpc_id" {}

variable "flow_logs_role_arn" {}

variable "main_log_group_name" {}
variable "satellite_log_group_name" {}

variable "tags" {
  type = map(string)
}