# resource "aws_db_subnet_group" "subnet_db_obl" {
#  name       = "subnet_db_obl"
#  subnet_ids = [aws_subnet.subnet_internal1.id,aws_subnet.subnet_internal2.id]
#  tags = {
#    Name = "Subnet para RDS Obligatorio "
#  }
# }
# 
# resource "aws_db_instance" "rds_obligatorio" {
#  allocated_storage      = 25
#  max_allocated_storage = 100
#  engine                 = "mysql"
#  engine_version         = "8.0.20"
#  instance_class         = "db.m5.large"
#  name                   = "rds-obligatorio"
#  username               = "admin"
#  password               = "admin01"
#  skip_final_snapshot    = true
#  vpc_security_group_ids = [aws_security_group.sg-http-internal-obligatorio.id]
#  db_subnet_group_name   = "subnet_db_obl"
# 
# }

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  cluster_identifier = aws_rds_cluster.rds-obligatorio.id
  instance_class     = "db.r5.large"
}

resource "aws_rds_cluster" "rds-obligatorio" {
  cluster_identifier = "rds-obligatorio"
  availability_zones = ["us-east-1a", "us-east-1b"]
  database_name      = "db_obligatorio"
  master_username    = "admin"
  master_password    = "adminadmin"
}