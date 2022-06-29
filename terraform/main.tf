provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["amazon"]
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"
  count   = 1
  name = "netology_ubuntu"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"

  tags = {
    Environment = "dev"
  }
}