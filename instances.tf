
#INSTANCIAS DE ACCESO PUBLICO 

resource "aws_instance" "webserver1" {

  ami           = var.ami_centos
  instance_type = var.instance
  key_name      = var.key

  #Asociacion de VPC
  
  subnet_id              = aws_subnet.subnet_public1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg-http-obligatorio.id,aws_security_group.sg-ssh-obligatorio.id]
  tags = {
    Name      = "WebServer1"
  
  }

  connection {
    type = "ssh"
    user = "centos"
    host_key = file("/home/mauricio/Descargas/key-pair-obl.pem")
    host = aws_instance.webserver1.public_ip
  }
 
  provisioner "remote-exec" {
    inline = [ 
      "sudo su",
      "sudo yum -y update",
      "sudo yum -y install httpd",
      "systemctl start httpd",
      "systemctl enable httpd.service",
      "sudo yum -y install firewalld",
      "systemctl start firewalld",
      "firewall-cmd --add-service=http --permanent",
      "firewall-cmd --reload",
      "sudo systemctl start httpd",
    ]
  }


}

resource "aws_instance" "webserver2" {

  ami           = var.ami_centos
  instance_type = var.instance
  key_name      = var.key

  #Asociacion de VPC

  subnet_id = aws_subnet.subnet_public2.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg-http-obligatorio.id,aws_security_group.sg-ssh-obligatorio.id]
  tags = {
    Name      = "WebServer2"
  }

  connection {
    type = "ssh"
    user = "centos"
    host_key = file("/home/mauricio/Descargas/key-pair-obl.pem")
    host = aws_instance.webserver1.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo su",
      "sudo yum -y update",
      "sudo yum -y install httpd",
      "systemctl start httpd",
      "systemctl enable httpd.service",
      "sudo yum -y install firewalld",
      "systemctl start firewalld",
      "firewall-cmd --add-service=http --permanent",
      "firewall-cmd --reload",
      "sudo systemctl start httpd"
    ]
  }

}

######LOAD BALANCER#####

resource "aws_lb" "obligatorio_load_balancer" {
  name               = "obligatorioLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-http-obligatorio.id, aws_security_group.sg-ssh-obligatorio.id]
  subnets            = [aws_subnet.subnet_public1.id, aws_subnet.subnet_public2.id]

  tags = {
    Name = "obligatorio_load_balancer"
  }
}


######LOAD BALANCER LISTENER#####

resource "aws_lb_listener" "balanceador_listener" {
  load_balancer_arn = aws_lb.obligatorio_load_balancer.id
  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_obligatorio.id
  }
}

resource "aws_lb_target_group_attachment" "tg_webserver1" {
  target_group_arn = aws_lb_target_group.tg_obligatorio.id
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_webserver2" {
  target_group_arn = aws_lb_target_group.tg_obligatorio.id
  target_id        = aws_instance.webserver2.id
  port             = 80
}

resource "aws_lb_target_group" "tg_obligatorio" {
  name     = "tgObligatorioV1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_obligatorio.id
}



#INSTANCIAS PRIVADAS

#resource "aws_instance" "despliegue_wordpress" {

#  ami           = var.ami_centos
#  instance_type = var.instance
#  key_name      = var.key
  #asocia vpc
#  subnet_id              = aws_subnet.subnet_internal.id
#  vpc_security_group_ids = [aws_security_group.sg-http-internal.id, aws_security_group.sg-ssh.id]
#  tags = {
#    Name      = "Wordpress"
#    terraform = "True"
#  }

#  connection {
#    type = "ssh"
#    user = "root"
#    host_key = file("/home/danya/.ssh/id_rsa.pub")
#    host = aws_instance.despliegue_wordpress.public_ip
#  }

#  provisioner "remote-exec" {
#    inline = [
#      "yum install -y php-gd rsync httpd",
#      "service httpd restart",
#      "wget -P ~/ http://wordpress.org/latest.tar.gz",
#      "tar xzvf latest.tar.gz",
#      "rsync -avP ~/wordpress/ /var/www/html/",
#      "mkdir /var/www/html/wp-content/uploads",
#      "chown -R apache:apache /var/www/html/*",
#    ]
#  }

#  provisioner "file" {
#    source      = "files/wordpress/wp-config.php"
#    destination = "/var/www/html/wp-config.php"
#  }

#  provisioner "remote-exec" {
#    inline = [
#      "systemctl restart httpd",
#    ]
#  }

#}

