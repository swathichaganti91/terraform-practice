variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}
variable "vpc_name" {
    type = string
    default = "swathi"
  
}
variable "subnet_cidr" {
    type = string
    default = "10.0.0.0/24"

  
}
variable "subnet_availability_zone" {
    type = string
    default = "ap-south-1a"
  
}
variable "subnet_name" {
    type = string
    default = "junnu"
  
}
variable "route_table" {
    type = string
    default = "publiRT"
  

}
variable "igw" {
    type = string
    default = "internet"
  
}