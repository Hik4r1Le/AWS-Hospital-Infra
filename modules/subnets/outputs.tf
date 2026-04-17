output "public_az1_id" {
  value = aws_subnet.public_az1.id
}

output "public_az2_id" {
  value = aws_subnet.public_az2.id
}

output "private_clinical_az1_id" {
  value = aws_subnet.private_clinical_az1.id
}

output "private_clinical_az2_id" {
  value = aws_subnet.private_clinical_az2.id
}

output "private_staff_main_id" {
  value = aws_subnet.private_staff_az1.id
}

output "private_iot_main_id" {
  value = aws_subnet.private_iot_az1.id
}

output "private_patient_id" {
  value = aws_subnet.private_patient_az1.id
}

output "satellite_public_id" {
  value = aws_subnet.sat_public_az1.id
}

output "satellite_staff_id" {
  value = aws_subnet.sat_private_staff_az1.id
}

output "satellite_iot_id" {
  value = aws_subnet.sat_private_iot_az1.id
}