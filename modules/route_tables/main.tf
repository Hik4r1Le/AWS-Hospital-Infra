# Route table for 2 public subnet (az1 and az2) of main hospital VPC
resource "aws_route_table" "main_vpc_public" {
  vpc_id = var.main_hospital_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.main_hospital_igw_id
  }

  tags = {
    Name = "main-hospital-vpc-public-subnet-rt"
  }
}

resource "aws_route_table_association" "main_vpc_public" {
  count = length(var.main_hospital_public_subnet_ids)
  subnet_id      = var.main_hospital_public_subnet_ids[count.index]
  route_table_id = aws_route_table.main_vpc_public.id
}

# Route table for 2 clinical subnet (az1 + az2)  of main hospital VPC
resource "aws_route_table" "main_vpc_clinical_az1" {
  vpc_id = var.main_hospital_vpc_id

  route {
    cidr_block = var.satellite_clinic_vpc_cidr_block
    transit_gateway_id = var.transit_gateway_id
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.main_hospital_ngw_az1_id
  }

  tags = {
    Name = "main-hospital-vpc-clinic-subnet-az1-rt"
  }
}

resource "aws_route_table_association" "main_vpc_clinical_az1" {
  subnet_id      = var.main_hospital_clinical_subnet_az1_id
  route_table_id = aws_route_table.main_vpc_clinical_az1.id
}

resource "aws_route_table" "main_vpc_clinical_az2" {
  vpc_id = var.main_hospital_vpc_id

  route {
    cidr_block = var.satellite_clinic_vpc_cidr_block
    transit_gateway_id = var.transit_gateway_id
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.main_hospital_ngw_az2_id
  }

  tags = {
    Name = "main-hospital-vpc-clinic-subnet-az2-rt"
  }
}

resource "aws_route_table_association" "main_vpc_clinical_az2" {
  subnet_id      = var.main_hospital_clinical_subnet_az2_id
  route_table_id = aws_route_table.main_vpc_clinical_az2.id
}

# Route table for staff/patient/iot subnet of main hospital VPC
resource "aws_route_table" "main_vpc_private_az1" {
  vpc_id = var.main_hospital_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.main_hospital_ngw_az2_id
  }

  tags = {
    Name = "main-hospital-vpc-private-subnet-az1-rt"
  }
}

resource "aws_route_table_association" "main_vpc_staff" {
  subnet_id      = var.main_hospital_staff_subnet_id
  route_table_id = aws_route_table.main_vpc_private_az1.id
}

resource "aws_route_table_association" "main_vpc_iot" {
  subnet_id      = var.main_hospital_iot_subnet_id
  route_table_id = aws_route_table.main_vpc_private_az1.id
}

resource "aws_route_table_association" "main_vpc_patient" {
  subnet_id      = var.main_hospital_patient_subnet_id
  route_table_id = aws_route_table.main_vpc_private_az1.id
}

# Route table for public subnet of satellite clinic VPC
resource "aws_route_table" "satellite_vpc_public" {
  vpc_id = var.satellite_clinic_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.satellite_clinic_igw_id
  }

  tags = {
    Name = "satellite-clinic-vpc-public-subnet-rt"
  }
}

resource "aws_route_table_association" "satellite_vpc_public" {
  subnet_id      = var.satellite_clinic_public_subnet_id
  route_table_id = aws_route_table.satellite_vpc_public.id
}

# Route table for staff subnet of satellite clinic VPC
resource "aws_route_table" "satellite_vpc_staff" {
  vpc_id = var.satellite_clinic_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.satellite_clinic_ngw_id
  }
  
  route {
    cidr_block = var.main_hospital_vpc_cidr_block
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "satellite-clinic-vpc-staff-subnet-rt"
  }
}

resource "aws_route_table_association" "satellite_vpc_staff" {
  subnet_id      = var.satellite_clinic_staff_subnet_id
  route_table_id = aws_route_table.satellite_vpc_staff.id
}

# Route table for iot subnet of satellite clinic VPC
resource "aws_route_table" "satellite_vpc_iot" {
  vpc_id = var.satellite_clinic_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.satellite_clinic_ngw_id
  }

  tags = {
    Name = "satellite-clinic-vpc-iot-subnet-rt"
  }
}

resource "aws_route_table_association" "satellite_vpc_iot" {
  subnet_id      = var.satellite_clinic_iot_subnet_id
  route_table_id = aws_route_table.satellite_vpc_iot.id
}
