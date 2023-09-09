resource "aws_route_table" "test-routetable" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "test-routetable"
  }
}

resource "aws_route" "route-to-igw" {
  route_table_id         = aws_route_table.test-routetable.id
  gateway_id             = aws_internet_gateway.test-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.test-subnet-a.id
  route_table_id = aws_route_table.test-routetable.id
}