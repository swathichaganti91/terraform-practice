resource "aws_instance" "name" {
    ami = "ami-0861f4e788f5069dd"
    instance_type = "t3.micro"
    count = length(var.ec2)
    tags = {
      Name = var.ec2[count.index]
    }
  
}
variable "ec2" {
    type = list(string)
    default = [ "junnu","prateek","swathi" ]
  
}