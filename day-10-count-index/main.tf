resource "aws_instance" "name" {
    ami = "ami-0b982602dbb32c5bd"
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
