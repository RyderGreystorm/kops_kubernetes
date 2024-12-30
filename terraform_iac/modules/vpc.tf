resource "aws_vpc" "kops-server" {
  cidr_block = var.cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "kops"
  }
}


#Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kops-server.id

  tags = {
    Name = "main"
  }

}


#Public subnet
resource "aws_subnet" "pub-sub" {
  count = length(var.availability_zones)
  vpc_id     = aws_vpc.kops-server.id
  cidr_block = element(var.pub-cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-subnet${count.index}"
  }
}


#Route Table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.kops-server.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt"
  }
}

#Public Route table association
resource "aws_route_table_association" "pub-rt-assoc" {
  count = length(var.availability_zones)
  subnet_id      = aws_subnet.pub-sub[count.index].id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_security_group" "kops-server-sg" {
  name        = "kops-server-sg"
  description = "firewall for ec instance runnig kops"

  vpc_id = aws_vpc.kops-server.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Use your trusted IP here, this is a security risk, don't allow it like this. It should be your IP Address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kops_Host"
  }
}