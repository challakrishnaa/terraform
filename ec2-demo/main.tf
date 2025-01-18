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
