resource "aws_instance" "proxy" {
  # Amazon Linux 2023 AMI
  ami                         = "ami-079cd5448deeace01"
  availability_zone           = "ap-northeast-1a"
  instance_type               = "t2.micro"
  key_name                    = "proxy"
  subnet_id                   = aws_subnet.proxy-subnet-a.id
  vpc_security_group_ids      = [aws_security_group.proxy-sg.id]
  associate_public_ip_address = false
  private_ip                  = "10.40.0.10"
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }
  user_data = <<EOF
    #!/bin/bash
    sudo nmcli general hostname proxy
    sudo yum update -y
    sudo yum install -y squid
    sudo systemctl enable --now squid
  EOF
  tags = {
    "Name" = "proxy"
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_eip" "proxy-eip" {
  instance = aws_instance.proxy.id
  vpc      = true
}

output "elastic_ip" {
  description = "Elastic IP Address of EC2 Instance."
  value = aws_eip.proxy-eip.public_ip
}