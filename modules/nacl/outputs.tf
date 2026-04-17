output "nacl_public_id" {
  value = aws_network_acl.public.id
}

output "nacl_clinical_id" {
  value = aws_network_acl.clinical.id
}

output "nacl_staff_id" {
  value = aws_network_acl.staff.id
}

output "nacl_iot_id" {
  value = aws_network_acl.iot.id
}

output "nacl_patient_id" {
  value = aws_network_acl.patient.id
}