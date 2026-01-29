resource "aws_vpc" "jenkins-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.vpc-name
  }
}

# subents, igw, route table and route table  associations, secutity group
# subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.jenkins-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
}
# igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.jenkins-vpc.id
  tags = {
    Name = var.igw-name
  }
}
#route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.jenkins-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.rt-name
  }
}

resource "aws_route_table_association" "rts" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "security-group" {
  vpc_id      = aws_vpc.jenkins-vpc.id
  description = "Allowing Jenkins, SonarQube and SSH access "

  ingress = [
    for port in [22, 8080, 9000] : {
      description    = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      security_groups = []
      prefix_list_ids  = []
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg-name
  }
}



