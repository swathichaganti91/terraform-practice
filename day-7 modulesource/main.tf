provider "aws" {
    region = "ap-south-1"
  
}
resource "aws_instance" "name" {
    ami = var.instance_ami
    instance_type = var.instance_type

    tags = {
      Name = var.instance_name
    }
  
}