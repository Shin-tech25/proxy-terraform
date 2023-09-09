resource "aws_vpc" "test-vpc" {
  cidr_block           = "10.40.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "test-main"
  }
}

resource "aws_subnet" "test-subnet-a" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "10.40.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "test-subnet-a"
  }
}