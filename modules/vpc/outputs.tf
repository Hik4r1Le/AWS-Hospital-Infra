output "main_vpc_id" {
  value = aws_vpc.main.id
}

output "satellite_vpc_id" {
  value = aws_vpc.satellite.id
}

output "main_vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "satellite_vpc_cidr_block" {
  value = aws_vpc.satellite.cidr_block
}