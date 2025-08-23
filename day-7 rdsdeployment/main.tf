provider "aws" {
  region = "ap-south-1"
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name        = "rds/admin-credentials"
  description = "RDS admin credentials"
}

resource "random_password" "rds_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id     = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.rds_password.result
  })
}

data "aws_secretsmanager_secret" "rds_secret_data" {
  name = aws_secretsmanager_secret.rds_credentials.name
}

data "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = data.aws_secretsmanager_secret.rds_secret_data.id

  depends_on = [
    aws_secretsmanager_secret_version.rds_credentials_version
  ]
}

locals {
  rds_secret = jsondecode(data.aws_secretsmanager_secret_version.rds_secret_version.secret_string)
}

module "rds" {
  source = "..terraforn-practice/day-7-rds-creation"

  db_identifier              = "my-db"
  engine                     = "mysql"
  engine_version             = "8.0"
  allocate_storage           = 20
  instance_class             = "db.t3.micro"
  username                   = local.rds_secret.username
  password                   = local.rds_secret.password
  db_name                    = "mydatabase"
  db_subnet_group_name       = "my-db-subnet-group"
  vpc_name                   = "my-vpc"
  vpc_cidr                   = "10.0.0.0/16"
  security_group_name        = "rds-sg"
  security_group_description = "Allow MySQL access"

  subnets = [
    { name = "subnet-1", cidr_block = "10.0.1.0/24" },
    { name = "subnet-2", cidr_block = "10.0.2.0/24" }
  ]

  security_group_ingress = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.0/24"]  # Replace with your IP
    }
  ]

  security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

resource "aws_iam_policy" "read_secrets_policy" {
  name        = "ReadSecretsPolicy"
  description = "Allows reading RDS secrets from Secrets Manager"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowReadSecrets"
        Effect   = "Allow"
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "arn:aws:secretsmanager:ap-south-1:554930853277:secret:rds/*"
      }
    ]
  })
}

resource "aws_iam_user" "terraform_user" {
  name = "terraform"
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.read_secrets_policy.arn
}
