provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "demo-server" {
    ami = ""
    instance_type = "t3.micro"
    key_name = "devops"

    tags = {
        Name = "demo-server"
    }
}
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.10.0.0/16" # This is the cidr_block of the VPC

    tags = {
        Name = "my-vpc" # This is the name of the VPC
    }

}
