# Security Group of the Jenkins server
resource "aws_default_security_group" "jenkins-sg" {
  vpc_id = aws_vpc.my-vpc.id
  # Allow inbound TCP traffic on port 22 (SSH) from any source 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  # Allow inbound TCP traffic on port 8080 (Jenkins) from any source.
  # This is the default port for Jenkins, so we open it to the Internet
  # because we will access it from a web browser
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  # Allow all outbound traffic to any destination
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}
