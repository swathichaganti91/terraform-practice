data "terraform_remote_state"{
    backend = "local"
    config = {
        path = "../day-9-root-child-module/terraform.tfstate"
    }

}




resource "aws_security_group" "name" {
    name = "swathi-sg"
    ingress = [ 
        for port in [22,80,443,9000,3000,8082] : {
        description = "inbound rules"
        from_port   = port
        to_port     = port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        self        = false
        }
     ]
     egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
     }
     tags = {
       Name = "swathi-sg"
     }

  
}
variable "allowed_ports" {
    type = map(string)
    default = {
      22 = "0.0.0.0/0"
      80 = "10.0.0.0/24"
      443 = "183.82.125.5/32"
      9000 = "0.0.0.0/0"

    }
  
}