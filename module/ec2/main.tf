resource "aws_instance" "instance" {
  ami                         = var.ami-id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [ aws_security_group.security-group.id ]
  subnet_id                   = var.subnet-a-id
  associate_public_ip_address = true
  user_data                   = <<EOF
#!/bin/sh
yum install -y nginx
service nginx start
EOF
}

resource "aws_security_group" "security-group" {
  vpc_id = var.vpc-id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}