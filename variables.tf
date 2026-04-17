variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment is not included in: dev, staging, prod"
  }
}

variable "keypair_path" {
  type = string
}

variable "iam_user_list" {
  type = list(string)
}