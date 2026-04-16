resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "main"
  subnet_ids = var.main_hospital_clinical_subnets

  tags = {
    Name = "mysql-subnet-group"
  }
}

resource "aws_db_instance" "mysql_db" {
  identifier        = "main-hospital-mysql-db"
  engine            = "mysql"
  engine_version    = "8.4.8"
  multi_az          = true
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name                       = "mydb_test"
  username                      = "admin"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = var.rds_kms_key_id

  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  publicly_accessible    = false
  vpc_security_group_ids = var.vpc_security_group_ids

  skip_final_snapshot     = true
  backup_retention_period = 7

  tags = {
    Name = "main-hospital-mysql-db"
  }
}
