provider "aws" {
  region = "ap-south-1"
}
data "aws_ami" "example" {
  most_recent = true
  owners      = ["amazon"]
}
resource "aws_instance" "example" {
  ami           = data.aws_ami.example.id
  instance_type = "t2.micro"
}