# =========================
# MAIN HOSPITAL VPC
# =========================

resource "aws_subnet" "public_az1" {
  vpc_id                  = var.main_vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = { Name = "public-az1" }
}

resource "aws_subnet" "public_az2" {
  vpc_id                  = var.main_vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = { Name = "public-az2" }
}

resource "aws_subnet" "private_clinical_az1" {
  vpc_id            = var.main_vpc_id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "ap-southeast-1a"

  tags = { Name = "private-clinical-az1" }
}

resource "aws_subnet" "private_clinical_az2" {
  vpc_id            = var.main_vpc_id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-southeast-1b"

  tags = { Name = "private-clinical-az2" }
}

resource "aws_subnet" "private_staff_az1" {
  vpc_id            = var.main_vpc_id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "ap-southeast-1a"

  tags = { Name = "private-staff-az1" }
}

resource "aws_subnet" "private_iot_az1" {
  vpc_id            = var.main_vpc_id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "ap-southeast-1a"

  tags = { Name = "private-iot-az1" }
}

resource "aws_subnet" "private_patient_az1" {
  vpc_id            = var.main_vpc_id
  cidr_block        = "10.0.40.0/24"
  availability_zone = "ap-southeast-1a"

  tags = { Name = "private-patient-az1" }
}

# =========================
# SATELLITE CLINIC VPC
# =========================

resource "aws_subnet" "sat_public_az1" {
  vpc_id                  = var.satellite_vpc_id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = { Name = "sat-public-az1" }
}

resource "aws_subnet" "sat_private_staff_az1" {
  vpc_id            = var.satellite_vpc_id
  cidr_block        = "10.1.10.0/24"
  availability_zone = "ap-southeast-1a"

  tags = { Name = "sat-private-staff-az1" }
}

resource "aws_subnet" "sat_private_iot_az1" {
  vpc_id            = var.satellite_vpc_id
  cidr_block        = "10.1.20.0/24"
  availability_zone = "ap-southeast-1a"

  tags = { Name = "sat-private-iot-az1" }
}