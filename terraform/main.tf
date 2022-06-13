provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["amazon"]
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_instance" "netology_ubuntu" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
}