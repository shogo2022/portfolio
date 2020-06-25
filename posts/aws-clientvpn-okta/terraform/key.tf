#Temporary key pair for EC2 
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  # client vpn endpoint only supports 1024 or 2048. 4096 is not supported as of June 2020.
  rsa_bits  = 2048
}