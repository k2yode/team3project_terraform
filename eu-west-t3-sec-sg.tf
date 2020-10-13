
################################
# Security Group
################################
resource "aws_security_group" "eu-west-t3-sec-sg" {
  name = "AWS-Team3-SecGroup"

  tags = {
    Name = "EU-West-Firewall"
  }

  ################################
  # Inbound SSH from anywhere
  ################################

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ################################
  # Outbound SSH from anywhere
  ################################
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
