
// vpc code


 resource "aws_vpc" "vpc1" {
  cidr_block       = "172.120.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "utc-app"
    env = "Dev"
    Team = "DevOps"
  }
} 
## Internet gateway

resource "aws_internet_gateway" "igtw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "utc-app"
    env = "Dev"
    Team = "DevOps"
  }
}

// Public subnets

##  Public Subnet1

resource "aws_subnet" "pubsub1" {
  vpc_id     = aws_vpc.vpc1.id
  map_public_ip_on_launch = true
  cidr_block = "172.120.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-us-east-1a"
  }
}

##  Public Subnet2

resource "aws_subnet" "pubsub2" {
  vpc_id     = aws_vpc.vpc1.id
  map_public_ip_on_launch = true
  cidr_block = "172.120.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "public-us-east-1b"
  }
}

// Private subnets

## private subnet1

resource "aws_subnet" "privsub1" {
  vpc_id     = aws_vpc.vpc1.id
  map_public_ip_on_launch = true
  cidr_block = "172.120.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-us-east-1a"
  }
}

## Private subnet2

resource "aws_subnet" "privsub2" {
  vpc_id     = aws_vpc.vpc1.id
  map_public_ip_on_launch = true
  cidr_block = "172.120.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-us-east-1b"
  }
}

## NAT Gateway

resource "aws_eip" "eip1" {
}


resource "aws_nat_gateway" "gtw1" {
  subnet_id = aws_subnet.pubsub1.id
  allocation_id = aws_eip.eip1.id
  tags = {
    Name = "Natgateway"
    env = "Dev"
  } 
}


// Private route table

resource "aws_route_table" "prirt" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.gtw1.id
  }
}

  ## Public route table
resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igtw1.id
  }
}

## Private route table association

resource "aws_route_table_association" "prirta1" {
  subnet_id      = aws_subnet.privsub1.id
  route_table_id = aws_route_table.prirt.id
}

resource "aws_route_table_association" "prirta2" {
  subnet_id      = aws_subnet.privsub2.id
  route_table_id = aws_route_table.prirt.id
}

## Public route table association

resource "aws_route_table_association" "pubrta1" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.pubrt.id
}

resource "aws_route_table_association" "pubrta2" {
  subnet_id      = aws_subnet.pubsub2.id
  route_table_id = aws_route_table.pubrt.id
}



