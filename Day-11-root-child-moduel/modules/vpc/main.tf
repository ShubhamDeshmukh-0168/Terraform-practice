resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "sd- VPC"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_1_cidr
  availability_zone = var.az1
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_2_cidr
    availability_zone = var.az2

  
}
resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "subnet_1_id" {
  value = "${aws_subnet.main.id}"
}

output "subnet_2_id" {
  value = "${aws_subnet.name.id}"
}