resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sd-vpc"
  }
}

resource "aws_subnet" "name" {
  vpc_id            = aws_vpc.name.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "sd-subnet"
  }
}

resource "aws_subnet" "name2" {
  vpc_id            = aws_vpc.name.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.5.0/24"

  tags = {
    Name = "sd-subnet2"
  }
}

resource "aws_db_subnet_group" "subnet" {
  name       = "sd-subnet-group"
  subnet_ids = [aws_subnet.name.id, aws_subnet.name2.id]

  tags = {
    Name = "sd-subnet-group"
  }
}

# PRIMARY DATABASE
resource "aws_db_instance" "main" {
  identifier              = "sd-db-instance"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"

  #manage_master_user_password = true # password will be generated and stored in Secrets Manager
  #MySQL + Secrets Manager + Read Replica → NOT supported we can manually integrate Secrets Manager and still use replicas.
  password = "shubham!134" #self-managed password 
  db_subnet_group_name    = aws_db_subnet_group.subnet.name

  backup_retention_period = 1
  skip_final_snapshot     = true

  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn
}

# READ REPLICA
resource "aws_db_instance" "read_replica" {
  identifier          = "sd-db-replica"
  instance_class      = "db.t3.micro"

  replicate_source_db = aws_db_instance.main.identifier

  publicly_accessible = false
  skip_final_snapshot = true

  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn
}
####### IAM ROLE FOR RDS ENHANCED MONITORING
resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-enhanced-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

###### ELASTICACHE CLUSTER
resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "sd-redis-subnet-group"
  subnet_ids = [
    aws_subnet.name.id,
    aws_subnet.name2.id
  ]

  tags = {
    Name = "sd-redis-subnet-group"
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "sd-redis-cache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"

  subnet_group_name = aws_elasticache_subnet_group.redis_subnet.name
  port              = 6379

  tags = {
    Name = "sd-redis-cache"
  }
}