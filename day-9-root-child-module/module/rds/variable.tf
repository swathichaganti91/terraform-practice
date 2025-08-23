variable "db_name" {
    type = string
    default = ""
  
}
variable "db_username" {
    type = string
    default = ""
  
}
variable "db_password" {
    type = string
    default = ""
  
}
variable "db_allocate_storage" {
    type = number
    default = 20
  
}
variable "db_instance_class" {
    type = string
    default = ""
  
}
variable "subnet_ids" {
    type = list(string)
    default = []
  
}
variable "rds_subnet_group" {
    type = string
    default = ""
  
}
variable "db_identifier" {
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