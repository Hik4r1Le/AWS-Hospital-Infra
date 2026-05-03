output "rt_clinical_az1_id" {
  value = aws_route_table.main_vpc_clinical_az1.id
}

output "rt_clinical_az2_id" {
  value = aws_route_table.main_vpc_clinical_az2.id
}

output "rt_private_az1_id" {
  value = aws_route_table.main_vpc_private_az1.id
}
