resource "aws_security_group" "proxy-sg" {
  name        = "proxy-sg"
  vpc_id      = aws_vpc.proxy-vpc.id
  description = "Security group for proxy instance."
}

resource "aws_security_group_rule" "inbound_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.proxy-sg.id
}

resource "aws_security_group_rule" "inbound_squid" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.proxy-sg.id
}

resource "aws_security_group_rule" "outbound_all" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.proxy-sg.id
}