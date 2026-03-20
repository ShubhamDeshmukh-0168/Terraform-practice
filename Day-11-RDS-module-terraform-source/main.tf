module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "sd-db-instance"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "shubhamdb"
  username = "user"
  port     = "3306"

  #iam_database_authentication_enabled = true
   manage_master_user_password = true

  vpc_security_group_ids = ["sg-08e7b6f2def8e7890"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  #monitoring_interval    = "30"
  #monitoring_role_name   = "MyRDSMonitoringRole"
  #create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-0d8f402ba4b9434f2", "subnet-01228c2a7d7d5a793"]

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = true

  
  
}