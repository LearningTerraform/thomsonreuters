provider "aws" {
  region = var.region

}

resource "aws_instance" "base" {
  ami = lookup(var.ami, var.region)
  instance_type = var.instance_type

}

resource "aws_eip" "base" {
    instance = aws_instance.base.id
}
