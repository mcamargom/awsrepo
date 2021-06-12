resource "aws_vpc" "vpc_obligatorio" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "vpc_obligatorio"
  }
}

resource "aws_internet_gateway" "ig_obligatorio" {
  vpc_id = aws_vpc.vpc_obligatorio.id
  tags = {
    Name = "ig_obligatorio"
  }
}




