resource "aws_db_subnet_group" "this" {
    name = "var.rds_subnet_group"
    subnet_ids = var.subnet_ids


  
}
resource "aws_db_instance" "this" {
    identifier           = var.db_identifier
    allocated_storage    = var.db_allocate_storage
    engine               = var.db_engine
    engine_version       = var.db_engine_version
    instance_class       = var.db_instance_class
    db_name              = var.db_name
    username             = var.db_username
    password             = var.db_password
    db_subnet_group_name = aws_db_subnet_group.this.name
    skip_final_snapshot  = true
    publicly_accessible  = false

  
}
