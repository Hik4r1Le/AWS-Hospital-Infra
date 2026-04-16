output "tgw_id" {
  value = aws_ec2_transit_gateway.main.id
}

output "tgw_attachment_main_hospital_id" {
    value = aws_ec2_transit_gateway_vpc_attachment.main_hospital.id
}

output "tgw_attachment_satellite_clinic_id" {
    value = aws_ec2_transit_gateway_vpc_attachment.satellite_clinic.id
}

output "tgw_route_table_main_hospital_id" {
    value = aws_ec2_transit_gateway_route_table.main_hospital.id
}

output "tgw_route_table_satellite_clinic_id" {
    value = aws_ec2_transit_gateway_route_table.satellite_clinic.id
}


