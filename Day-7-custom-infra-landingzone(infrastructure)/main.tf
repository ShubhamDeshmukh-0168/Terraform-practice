resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "shubham-vpc"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "shubham-subnet1"
    }
}
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "shubham-subnet2"
    }
}
resource "aws_internet_gateway" "prod" {
    vpc_id = aws_vpc.prod.id
    tags = {
        Name = "shubham-igw"
    }
}

resource "aws_eip" "prod" {
    domain = "vpc"
}
  
resource "aws_nat_gateway" "prod" {
    allocation_id = aws_eip.prod.id
    subnet_id = aws_subnet.public.id
    tags = {
        Name = "shubham-nat"
    }
  
}
resource "aws_route_table" "prod2" {
    vpc_id= aws_vpc.prod.id
    
    route{
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.prod.id
}

}
resource "aws_route_table" "prod" {
  vpc_id= aws_vpc.prod.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id

  }
    
  }
resource "aws_route_table_association" "prod" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.prod.id
  
}
resource "aws_route_table_association" "prod2" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.prod2.id
  
}
resource "aws_security_group" "prod" {
    name = "shubham-sg"
    description = "Allow SSH and HTTP traffic"
    vpc_id = aws_vpc.prod.id


#inbound rule to allow SSH traffic from anywhere
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    #inbound rule to allow HTTP traffic from anywhere
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    #outbound rule to allow all traffic
    egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}
    
resource "aws_instance" "prod" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.prod.id]
    tags = {
        Name = "shubham-ec2"
    }
  
}