provider "aws" {
  
}
    
    
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
  
}
resource "aws_iam_user" "my_user" {
    name = "swathi"
  
}
resource "aws_iam_user_policy_attachment" "s3_readonly" {
    user = aws_iam_user.my_user.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  
}

