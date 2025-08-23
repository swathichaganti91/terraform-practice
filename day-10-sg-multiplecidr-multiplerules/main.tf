# Load VPC ID from remote state
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../day-9-root-child-module/terraform.tfstate"
  }
}

# Security Group 1 - static + dynamic example
resource "aws_security_group" "swathi_sg" {
  name   = "swathi-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  # Dynamic ingress for ports [22, 80]
  dynamic "ingress" {
    for_each = toset([22, 80])
    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Egress (allow all)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "swathi-sg"
  }
}

# Variable for dynamic ports + CIDRs
variable "allowed_ports" {
  type = map(string)
  default = {
    3000 = "0.0.0.0/0"
    8000 = "183.82.125.5/32"
  }
}

# Security Group 2 - fully dynamic ingress
resource "aws_security_group" "this" {
  name        = "this"
  description = "Dynamic SG"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "Allow access to port ${ingress.key}"
      from_port   = tonumber(ingress.key)
      to_port     = tonumber(ingress.key)
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
