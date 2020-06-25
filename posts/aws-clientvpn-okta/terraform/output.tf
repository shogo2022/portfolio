#EC2 Private IP
output server_private_ip_address {
  value = aws_instance.portfolio_web[0].private_ip
}

#Scenario goals
output goal {
  value = "Configure ACM, and Client VPN. Once configured, you should be able to access private ip address with your web browser."
}