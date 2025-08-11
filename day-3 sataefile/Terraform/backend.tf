terraform {
  backend "s3" {
    bucket = "theswathi.shop"    # your bucket name here
    key    = "terraform.tfstate"   # path inside the bucket for the state file
    region = "us-east-1"                    # your AWS region
    encrypt = true                         # enable encryption at rest
  }
}
