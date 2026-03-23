resource "aws_instance" "web" {
  ami       = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "sd EC2 Instance"
    }
  
}