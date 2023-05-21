resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support

  tags = {
    Name = "myvpc"
  }
}

resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "mygateway"
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public-subnet-1-cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.public-subnet-2-cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private-subnet-1-cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.private-subnet-2-cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.myvpc.id

  route = []
  tags = {
    Name = var.public-route-table
  }
}

resource "aws_route" "public-route" {
  route_table_id            = aws_route_table.public-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.mygateway.id
  depends_on                = [aws_route_table.public-route-table]

}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.myvpc.id

  route = []
  tags = {
    Name = var.private-route-table
  }
}

resource "aws_route_table_association" "public-association1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "public-association2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-association1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-association2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}



