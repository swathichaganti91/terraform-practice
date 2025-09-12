#provider "aws" {
  
#}
    
    
#resource "aws_vpc" "my_vpc" {
 #   cidr_block = "10.0.0.0/16"
  
#}
#resource "aws_iam_user" "my_user" {
 #   name = "swathi"
  
#}
#resource "aws_iam_user_policy_attachment" "s3_readonly" {
 #   user = aws_iam_user.my_user.name
  #  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  
#}
# Specify the AWS provider
provider "aws" {
  region = "ap-south-1"   # Change region if needed
}

# Create a security group
#resource "aws_security_group" "ec2_sg" {
 # name        = "jenkins-ec2-sg"
  #description = "Allow SSH and HTTP access"

  #ingress {
   # from_port   = 22
    #to_port     = 22
    #protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (you can restrict)
  #}

  #ingress {
   # from_port   = 80
    #to_port     = 80
    #protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  #}

  #egress {
    #from_port   = 0
    #to_port     = 0
    #protocol    = "-1"
    #cidr_blocks = ["0.0.0.0/0"]
  #}
#}

# Create an EC2 instance
#resource "aws_instance" "my_ec2" {
 # ami           = "ami-0b982602dbb32c5bd"   # Amazon Linux 2023 in ap-south-1
  #instance_type = "t3.micro"
  #key_name      = "ap-south-1a"                  # Change to your key pair name
 # security_groups = [aws_security_group.ec2_sg.name]

  #tags = {
   # Name = "Jenkins---EC2"
  #}
#}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-simple-gcfrdtghbczzsgbkzw-bucket"
  acl    = "private"
}
terraform {
  backend "s3" {
    bucket = "my-simple-gcfrdtghbczzsgbkzw-bucket"  # Your existing S3 bucket
    key    = "terraform-practice/day-10-import/terraform.tfstate"  # Path inside bucket
    region = "ap-south-1"                                 # Bucket region
    encrypt = true                                        # Enable encryption
  }
}


