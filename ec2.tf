resource "aws_instance" "terraform-ec2-01" {
  ami                         = "ami-02892a4ea9bfa2192"
  availability_zone           = "ap-northeast-1a"
  instance_type               = "t2.micro"
  key_name                    = "proxy"
  subnet_id                   = aws_subnet.test-subnet-a.id
  vpc_security_group_ids      = [aws_security_group.test-sg.id]
  associate_public_ip_address = false
  private_ip                  = "10.40.0.10"
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y squid
    sudo systemctl enable --now squid
  EOF
  tags = {
    "Name" = "terraform-ec2-01"
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_eip" "ec2-eip" {
  instance = aws_instance.terraform-ec2-01.id
  vpc      = true
}

output "elastic_ip" {
  description = "Elastic IP Address of EC2 Instance."
  value = aws_eip.ec2-eip.public_ip
}