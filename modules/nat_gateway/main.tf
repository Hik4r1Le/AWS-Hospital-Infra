resource "aws_nat_gateway" "main_az1" {
  allocation_id = var.eip_nat_main_az1_id
  subnet_id     = var.public_az1_subnet_id

  tags = merge(var.tags, {
    Name = "nat-main-az1"
  })

  depends_on = [var.main_igw_id]
}

resource "aws_nat_gateway" "main_az2" {
  allocation_id = var.eip_nat_main_az2_id
  subnet_id     = var.public_az2_subnet_id

  tags = merge(var.tags, {
    Name = "nat-main-az2"
  })

  depends_on = [var.main_igw_id]
}

resource "aws_nat_gateway" "satellite" {
  allocation_id = var.eip_nat_satellite_id
  subnet_id     = var.satellite_public_subnet_id

  tags = merge(var.tags, {
    Name = "nat-satellite"
  })

  depends_on = [var.satellite_igw_id]
}