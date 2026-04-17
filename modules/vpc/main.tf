resource "aws_vpc" "main" {
  cidr_block           = var.main_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-hospital-vpc"
  }
}

resource "aws_vpc" "satellite" {
  cidr_block           = var.satellite_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "satellite-clinic-vpc"
  }
}