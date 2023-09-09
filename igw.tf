resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.test-vpc.id

  tags = {
    Name = "main-igw"
  }
}