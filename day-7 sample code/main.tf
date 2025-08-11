module "ec2-module" {
  source         = "../day-7 modulesource"
  instance_ami   = "ami-0144277607031eca2"
  instance_name  = "my-ec2 instance"
  instance_type  = "t2.micro"
  acl            = "private"  # or "public-read"
}
