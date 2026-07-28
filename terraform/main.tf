provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "example" {
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
}