output "sg_alb_internal_id" {
  value = aws_security_group.alb_internal.id
}

output "sg_ec2_his_id" {
  value = aws_security_group.ec2_his.id
}

output "sg_rds_id" {
  value = aws_security_group.rds.id
}

output "sg_staff_workstation_id" {
  value = aws_security_group.staff_workstation.id
}

output "sg_iot_main_id" {
  value = aws_security_group.iot_main.id
}

output "sg_patient_wifi_id" {
  value = aws_security_group.patient_wifi.id
}