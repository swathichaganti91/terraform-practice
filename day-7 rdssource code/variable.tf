variable "db_identifier" {
    description = "the DB identifier"
    type = string
  
}
variable "engine" {
    description = "database engine"
    type = string
  
}
variable "engine_version" {
    description = "database engine version"
    type = string
  
}
variable "allocate_storage" {
    description = "Allocate storage in DB"
    type = number
  
}
variable "instance_class" {
    description = "instance type for RDS"
    type = string
  
}
variable "username" {
    description = "the username for database"
    type = string
  
}
variable "password" {
    description = "the password for database"
    type = string
  
}
variable "subnets" {
    description = "list of subnets with name and cidr blocks"
    type = list(object({
      name = string
      cidr_block = string
    }))
  
}
variable "db_subnet_group_name" {
    description = "name of db subnet grp"
    type = string
  
}
variable "vpc_name" {
    description = "Name of the vpc"
    type = string
  
}
variable "vpc_cidr" {
    description = "cidr block for vpc"
    type = string
  
}
variable "db_name" {
    description = "intial database name"
    type = string
  
}
variable "security_group_name" {
    description = "the security group"
    type = string
    
  
}
variable "security_group_ingress" {
    description = "list of ingrss rules"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string) 
    }))
  
}
variable "security_group_egress" {
    description = "list of egress rules"
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      cidr_blocks = list(string)
    }))
  
}
variable "security_group_description" {
    description = "security group description"
    type = string
  
}