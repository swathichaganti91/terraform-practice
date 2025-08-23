

provider "aws" {
  region = "ap-south-1"
}

# Get availability zones for subnets
data "aws_availability_zones" "available" {}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Create subnets dynamically
resource "aws_subnet" "db_subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = element(
    data.aws_availability_zones.available.names,
    index(keys(var.subnets), each.key)
  )

  tags = {
    Name = each.key
  }
}

# Create security group with dynamic ingress and egress rules
resource "aws_security_group" "rds_sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.security_group_name
  }
}

# Create DB subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = [for subnet in aws_subnet.db_subnets : subnet.id]

  tags = {
    Name = var.db_subnet_group_name
  }
}

# Create RDS instance
resource "aws_db_instance" "rds" {
  identifier             = var.db_identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocate_storage
  username               = var.username
  password               = var.password
  db_name                = var.db_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot    = true
  publicly_accessible    = true
  multi_az               = false
  deletion_protection    = false

  tags = {
    Name = var.db_identifier
  }
}
