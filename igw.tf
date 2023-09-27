resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.proxy-vpc.id

  tags = {
    Name = "main-igw"
  }
}