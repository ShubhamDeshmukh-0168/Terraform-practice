module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  subnet_1_cidr  = "10.0.1.0/24"
  subnet_2_cidr = "10.0.2.0/24"
  az1           = "us-east-1a"
  az2           = "us-east-1b"
}

module "ec2" {
   source        = "./modules/ec2"
   ami_id        = var.ami_id
   instance_type = var.instance_type
   subnet_1_id     = module.vpc.subnet_1_id
   
}

module "rds" {
  source           = "./modules/RDS"
  subnet_1_id      = module.vpc.subnet_1_id
  subnet_2_id      = module.vpc.subnet_2_id
  vpc_security_group_ids =  [module.vpc.db_sg_id]  
  instance_class   = var.instance_class
  db_name          = "mydb"
  db_user          = "admin"
  db_password      = var.db_password
}

module "s3" {
    source = "./modules/s3"
    bucket = "wertyuisdfghjxcfvgh"
  

}

#module "lambda" {
# source = "./modules/lambda"
#}

