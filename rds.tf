resource "aws_db_subnet_group" "subnet_db_obl" {
 name       = "subnet_db_obl"
 subnet_ids = [aws_subnet.subnet_internal1.id,aws_subnet.subnet_internal2.id]
 tags = {
   Name = "Subnet para RDS Obligatorio "
 }
}

resource "aws_db_instance" "rdsObligatorio" {
  allocated_storage    = 10
  max_allocated_storage    = 15
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "rdsDbObl"
  username             = "admin"
  password             = "adminadmin"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.subnet_db_obl.id

  tags = {
  Name = "RDS_DB_Obl"
}
}


#LOS PARAMETROS DEFINIDOS ANTERIORMENTE SON PROPIOS DE UNA CONFIGURACION DE TEST
#FREE TIER - T2.MICRO - STORAGE 





# resource "aws_rds_cluster_instance" "cluster_instances" {
  # count              = 2
  # cluster_identifier = aws_rds_cluster.rds-obligatorio.id
  # instance_class     = "db.r5.large"
  # engine             = "aws_rds_cluster.rds-obligatorio.aurora-mysql"
# }
# 
# resource "aws_rds_cluster" "rds-obligatorio" {
  # cluster_identifier = "rds-obligatorio"
  # availability_zones = ["us-east-1a", "us-east-1b"]
  # database_name      = "db_obligatorio"
  # master_username    = "admin"
  # master_password    = "adminadmin"
# }