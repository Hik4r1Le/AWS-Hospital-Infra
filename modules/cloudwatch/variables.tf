variable "alb_arn_suffix" {}

variable "ec2_his_az1_id" {}
variable "ec2_his_az2_id" {}

variable "rds_instance_id" {}

variable "vpn_endpoint_id" {}

variable "sns_alarm_email" {}

variable "tags" {
  type = map(string)
}