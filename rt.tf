resource "aws_route_table" "proxy-rt" {
  vpc_id = aws_vpc.proxy-vpc.id
  tags = {
    Name = "proxy-rt"
  }
}

resource "aws_route" "route-to-igw" {
  route_table_id         = aws_route_table.proxy-rt.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.proxy-subnet-a.id
  route_table_id = aws_route_table.proxy-rt.id
}