# Reusing existing configs created as part of EC2
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:name"
    values = [var.vpc-name]
  }
}

data "aws_subnet" "subnet" {
  filter {
    name   = "tag:name"
    values = [var.subnet-name]
  }
}

data "aws_internet_gateway" "igw" {
  filter {
    name   = "tag:name"
    values = [var.igw-name]
  }
}

data "aws_security_group" "sg-default" {
  filter {
    name   = "tag:name"
    values = [var.security-group-name]
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id                  = aws_vpc.jenkins-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet-name2
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.rt2-name
  }
}

resource "aws_route_table_association" "rt-association2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.rt2.id
}