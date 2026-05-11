variable "server_cert_arn" {
  type = string
}

variable "client_cert_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "allow_cidrs" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "cloudwatch_log_group_name" {
  type = string
}

variable "cloudwatch_log_stream_name" {
  type = string
}

