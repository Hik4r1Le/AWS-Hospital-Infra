output "main_igw_id" {
  value = aws_internet_gateway.main.id
}

output "satellite_igw_id" {
  value = aws_internet_gateway.satellite.id
}