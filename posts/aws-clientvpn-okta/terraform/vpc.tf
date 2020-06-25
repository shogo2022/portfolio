#Create vpc
resource "aws_vpc" "portfolio_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name       = "portfolio_vpc"
    Handsonlab = true
  }
}

#Create route table
resource "aws_route_table" "portfolio_private_rt" {
  vpc_id = aws_vpc.portfolio_vpc.id
  tags = {
    Name      = "portfolio_private_rt"
    Portfolio = true
  }
}

#Create subnet
resource "aws_subnet" "portfolio_private_net" {
  vpc_id            = aws_vpc.portfolio_vpc.id
  cidr_block        = "172.16.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name      = "portfolio_private_net"
    Portfolio = true
  }
}

# associate route table with subnet
resource "aws_route_table_association" "portfolio_private_assoc" {
  subnet_id      = aws_subnet.portfolio_private_net.id
  route_table_id = aws_route_table.portfolio_private_rt.id
}

resource "aws_security_group" "portfolio_web_sg" {
  vpc_id = aws_vpc.portfolio_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  name = "portfolio_web_sg"
}