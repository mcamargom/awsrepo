#resource "aws_db_subnet_group" "sg_db_obl" {
#  name       = "sg_db_obl"
#  subnet_ids = [aws_subnet.subnet_internal.id]
#  tags = {
#    Name = "My DB subnet group"
#  }
#}

#resource "aws_db_instance" "wordpress" {
#  allocated_storage      = 20
#  engine                 = "mysql"
#  engine_version         = "5.7"
#  instance_class         = "db.t3.micro"
#  name                   = "mywordpress"
#  username               = "wordpress"
#  password               = "pass1234"
#  skip_final_snapshot    = true
#  vpc_security_group_ids = [aws_security_group.sg-http-internal.id]
#  db_subnet_group_name   = aws_db_subnet_group.sg_grupo3.name

#}