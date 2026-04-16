output "rds_arn" {
  value = aws_db_instance.mysql_db.arn
}

output "rds_instance_id" {
  value = aws_db_instance.mysql_db.id
}

output "rds_endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}