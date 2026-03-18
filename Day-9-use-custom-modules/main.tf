module "ec2_instance" {
  source ="../Day-9-custom-modules"  # path to your module "This tells Terraform: Go to day9-custom-modules folder and use that code"
  
 ami_id        = "ami-02dfbd4ff395f2a1b"
  instance_type = "t2.micro"
}