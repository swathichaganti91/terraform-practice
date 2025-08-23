provider "aws" {
  
}

  
module "vpc" {
    source = "./module/vpc"

    vpc_cidr         = var.vpc_cidr
    vpc_name         = var.vpc_name
    subnet_name      = var.subnet_name
    subnet_cidr      = var.subnet_cidr
    availability_zone= var.subnet_availability_zone
    route_table      = var.route_table
    igw              = var.igw
  
}
module "rds" {
    source = "./module/rds"

    db_identifier = "swathi-rds"
    db_allocate_storage = 20
    db_instance_class = "db.t3.micro"
    db_engine              = "mysql"
    db_engine_version      = "8.0"
    db_username         = "admin1234"
    db_password         = "my-strong-haha"
    db_name             = "swathidb"
    rds_subnet_group    = "swathi-rds-subnetgroup"
    subnet_ids          = module.vpc.private_subnet_ids
    

  
}