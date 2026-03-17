# VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sd-vpc"
  }
}

# Subnet (Implicit Dependency)
resource "aws_subnet" "demo_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id   # reference
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "sd-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "sd-igw"
  }
}

# EC2 Instance (Explicit Dependency Example)
resource "aws_instance" "demo_ec2" {
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.demo_subnet.id


  tags = {
    Name = "sd-ec2"
 }

}

resource "aws_s3_bucket" "demo_bucket" {
    depends_on = [ aws_instance.demo_ec2 ] # Explicit dependency on EC2 instance
  bucket = "sd-demo-bucket-1234567890" # bucket name must be globally unique
  
}
 