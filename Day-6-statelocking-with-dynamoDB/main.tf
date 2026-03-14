resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "sd-vpc"
    }
}
resource "aws_instance" "name" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    tags = {
        Name = "sd-instance"
    }
  
}

resource "aws_subnet" "sample" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "sd-subnet"
    }
}

resource "aws_subnet" "apple" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "sd-subnet"
    }
}

resource "aws_instance" "dev" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.medium"
    tags = {
        Name = "dev-instance"
    }
}



  

