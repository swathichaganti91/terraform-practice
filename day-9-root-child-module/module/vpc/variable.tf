variable "vpc_cidr" {
    type = string
    default = ""
  
}
variable "vpc_name" {
    type = string
    default = ""
  
}
variable "subnet_cidr" {
    type = string
    default = ""
}
variable "availability_zone" {
    type = string
    default = ""
  
}
variable "subnet_name" {
    type = string
    default = ""
  
}
variable "igw" {
    type = string
    default = ""
  
}
variable "route_table" {
    type = string
    default = ""
  
}
variable "private_subnet_name" {
    type = string
    default = ""
  
}
variable "private2_subnet_name" {
    type = string
    default = ""
  
}
variable "db_engine" {
    type = string
    default = ""
  
}
variable "db_engine_version" {
    type = string
    default = ""
  
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      
    }
  }
}

