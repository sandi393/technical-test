# Output in the terminal the address of the Jenkins server, once it's created
output "ec2_public_ip" {
  value = aws_instance.myapp-server.public_ip
}
