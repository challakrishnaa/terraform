provider "aws" {
    region = "eu-north-1"
}
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.10.0.0/16"
}
resource "aws_internet_gateway" "my-igw"{
    vpc_id = aws_vpc.my-vpc.id

    tags = {
        Name = "my-igw"
    }
}
resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.my-vpc.id
    availability_zone = "eu-north-1a"
    cidr_block = "10.10.1.0/24"
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_1"
    }
}
resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.my-vpc.id
    availability_zone = "eu-north-1b"
    cidr_block = "10.10.2.0/24"
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_2"
    }
}
resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id

    }
}
resource "aws_route_table_association" "association-1" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.public_subnet_1.id
}
resource "aws_route_table_association" "association-2" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id = aws_subnet.public_subnet_2.id
}

resource "aws_security_group" "my-sg" {
    vpc_id = aws_vpc.my-vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "server-1" {
    ami = "ami-02df5cb5ad97983ba"
    instance_type = "t3.micro"
    availability_zone = "eu-north-1a"
    key_name = "devops"
    user_data = "httpd.sh"
    security_groups = [aws_security_group.my-sg.id]
    tags = {
        Name = "server-1"
    }

}
resource "aws_instance" "server-2" {
    ami = "ami-02df5cb5ad97983ba"
    instance_type = "t3.micro"
    availability_zone = "eu-north-1b"
    key_name = "devops"
    user_data = "./httpd/httpd.sh"
    security_groups = [aws_security_group.my-sg.id]
    tags = {
        Name = "server-2"
    }

}