resource "aws_security_group" "sg-ssh-obligatorio" {
  name        = "sg_ssh_obl"
  description = "Permitir trafico ssh entrante"
  vpc_id      = aws_vpc.vpc_obligatorio.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }



  egress {
    description      = "All out"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "permitir_ssh"
  }
}

resource "aws_security_group" "sg-http-obligatorio" {
  name        = "sg_http_obl"
  description = "Permitir trafico http entrante"
  vpc_id      = aws_vpc.vpc_obligatorio.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc_obligatorio.cidr_block]

  }

  egress {
    description      = "All out"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "permitir_http"
  }
}

resource "aws_security_group" "sg-http-internal-obligatorio" {
  name        = "sg_http_internal"
  description = "Permitir trafico http desde public"
  vpc_id      = aws_vpc.vpc_obligatorio.id

  ingress {
    description     = "HTTP from VPC"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-http-obligatorio.id]

  }

  egress {
    description      = "All out"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "permitir_http"
  }
}
