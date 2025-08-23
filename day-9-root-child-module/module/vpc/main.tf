


resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = var.vpc_name
    }
  
}
resource "aws_subnet" "main" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true
    tags = {
      Name = var.subnet_name
    }
  
}
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = var.route_table
    }
  
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = var.igw
    }
  
}
resource "aws_route" "name" {
    route_table_id = aws_route_table.name.id
    gateway_id = aws_internet_gateway.igw.id
    destination_cidr_block = "0.0.0.0/0"
    
  
}
resource "aws_route_table_association" "name" {
    subnet_id      = aws_subnet.main.id
    route_table_id = aws_route_table.name.id



  
}
resource "aws_subnet" "private" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      name = var.private_subnet_name

  
}
}
resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = var.private2_subnet_name
  }
  
  
  
}
