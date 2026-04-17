resource "aws_internet_gateway" "main" {
  vpc_id = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "igw-main-hospital"
  })
}

resource "aws_internet_gateway" "satellite" {
  vpc_id = var.satellite_vpc_id

  tags = merge(var.tags, {
    Name = "igw-satellite-clinic"
  })
}