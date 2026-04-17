resource "aws_eip" "nat_main_az1" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "eip-nat-main-az1"
  })
}

resource "aws_eip" "nat_main_az2" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "eip-nat-main-az2"
  })
}

resource "aws_eip" "nat_satellite" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "eip-nat-satellite"
  })
}