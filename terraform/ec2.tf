data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_default_vpc" "my_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "https_access" {
  name        = "https_access"
  description = "Allow HTTPS access"
  vpc_id      = aws_default_vpc.my_vpc.id

  ingress {
    description      = "HTTPS access from world"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_instance" "web_server" {

  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [ aws_security_group.https_access.name ]

  user_data = <<EOF
#!/bin/bash
apt update
apt install nginx
systemctl enable nginx
mkdir -p /etc/nginx/certs && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/nginx-selfsigned.key -out /etc/nginx/certs/nginx-selfsigned.crt -subj '/C=BR/ST=SP/L=SP/O=Nginx/CN=Teste'
echo 'c2VydmVyIHsKCiAgICBsaXN0ZW4gNDQzIGh0dHAyIHNzbDsKICAgIHNzbF9jZXJ0aWZpY2F0ZSAvZXRjL25naW54L2NlcnRzL25naW54LXNlbGZzaWduZWQuY3J0OwogICAgc3NsX2NlcnRpZmljYXRlX2tleSAvZXRjL25naW54L2NlcnRzL25naW54LXNlbGZzaWduZWQua2V5OwoKICAgIGxvY2F0aW9uIC8gewogICAgfQoKfQo=' | base64 -d > /etc/nginx/conf.d/secure.conf
nginx -s reload
EOF

  tags = {
    Name = "Sample webserver"
  }

}
