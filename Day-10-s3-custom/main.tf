
module "s3_bucket" {
  source = "../Day-10-modules-practice"

  bucket_name = "sfsldkfnslkdl909090"

  versioning = true

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}