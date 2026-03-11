 resource "aws_vpc"  "name" {
  cidr_block = "10.0.0.0/24"
  region = "us-east-1"
    tags = {
        Name = "shubham-vpc"
    }
}

resource "aws_instance" "name" {
  ami = "ami-02dfbd4ff395f2a1b"
  tags = {
    Name = "sdndd-instance"
  }
  instance_type = "t2.micro"
  
}