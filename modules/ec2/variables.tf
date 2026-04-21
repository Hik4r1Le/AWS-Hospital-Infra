variable "instance_type" {}
variable "private_clinical_az1_id" {}
variable "private_clinical_az2_id" {}

variable "sg_ec2_his_id" {}

variable "iam_instance_profile_name" {}

variable "kms_ebs_key_arn" {}

variable "tags" {
  type = map(string)
}