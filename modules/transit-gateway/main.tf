# Transit gateway
resource "aws_ec2_transit_gateway" "main" {
  description                     = "Transit Gateway for NT113 Project"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  auto_accept_shared_attachments  = "disable"

  tags = { Name = "tgw-main-hospital" }
}

# Transit gateway attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "main_hospital" {
  subnet_ids         = var.main_hospital_subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = var.main_hospital_vpc_id

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = { Name = "tgw-attachment-main-hospital-vpc" }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "satellite_clinic" {
  subnet_ids         = var.main_hospital_subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = var.satellite_clinic_vpc_id

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = { Name = "tgw-attachment-satellite-clinic-vpc" }
}

# Transit gateway route table
resource "aws_ec2_transit_gateway_route_table" "main_hospital" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags = { Name = "tgw-route-table-main-hospital-vpc" }
}

resource "aws_ec2_transit_gateway_route_table" "satellite_clinic" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags = { Name = "tgw-route-table-satellite-clinic-vpc" }
}

# Transit gateway route table association
resource "aws_ec2_transit_gateway_route_table_association" "main_hospital" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main_hospital.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main_hospital.id
}

resource "aws_ec2_transit_gateway_route_table_association" "satellite_clinic" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.satellite_clinic.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.satellite_clinic.id
}

# Transit gateway route table propagation
resource "aws_ec2_transit_gateway_route_table_propagation" "main_hospital" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main_hospital.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main_hospital.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "satellite_clinic" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.satellite_clinic.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.satellite_clinic.id
}