resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type   
    tags = {
      Name = "sd-instance"
    }
}
resource "aws_instance" "test" {
     ami = var.test_ami_id
    instance_type = var.test_instance_type
    provider = aws.testenv
    tags = {
        Name = "test-instance"
    }
}
resource "aws_instance" "prod" {
     ami = var.prod_ami_id
    instance_type = var.prod_instance_type
    provider = aws.prod
    tags = {
        Name = "prod-instance"
    }
}