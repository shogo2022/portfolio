#Store ssh key file to procure compute instance
resource "aws_key_pair" "portfolio_pub_key" {
  key_name   = "portfolio_pub_key"
  public_key = tls_private_key.my_key.public_key_openssh
  tags = {
    Portfolio = true
  }
}

#Create servers
resource "aws_instance" "portfolio_web" {
  ami                         = "ami-086c9e0eb8ef7f4cc" # preloaded web server based on Ubuntu 18.04 LTS
  instance_type               = "t2.micro"
  count                       = 1
  subnet_id                   = aws_subnet.portfolio_private_net.id
  key_name                    = aws_key_pair.portfolio_pub_key.key_name
  vpc_security_group_ids      = [aws_security_group.portfolio_web_sg.id]
  associate_public_ip_address = false

  tags = {
    Name      = format("portfolio_web%02d", count.index)
    Portfolio = true
  }
}