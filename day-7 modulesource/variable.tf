variable "instance_ami" {
    description = "AMI ID for the ec2 instance"
    type = string

  
}
variable "instance_type" {
    description = "type of ec2 instance"
    type = string
  

}
variable "instance_name" {
    description = "tag name of the instance"
    type = string
  
}
#variable "bucket_name" {
#    description = "name of the s3 bucket"
 #   type = string
  
#}
variable "acl" {
    description = "acl for the s3 bucket"
    type = string
}