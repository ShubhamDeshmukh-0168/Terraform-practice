
# --------------------
# S3 Bucket
# --------------------
resource "aws_s3_bucket" "bucket" {
  bucket = "deshmukhsd93-lambda-bucket"
}

# --------------------
# Upload ZIP code to S3
# --------------------
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.bucket.id
  key    = "lambda/app.py.zip"
  source = "app.py.zip"
  etag   = filemd5("app.py.zip")# To ensure that the object is updated in S3 when the local file changes
}


resource "aws_iam_role" "sd_lambda_role" {
  name = "shubhamsd_lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.sd_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_s3_read" {
  role       = aws_iam_role.sd_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
resource "aws_lambda_function" "my_lambda" {
  function_name = "sd_lambda_function"
  role          = aws_iam_role.sd_lambda_role.arn
  handler       = "app.py.lambda_handler"
  runtime       = "python3.12"

  timeout     = 900
  memory_size = 128

  # 🔑 Code pulled from S3 (NOT local)
  s3_bucket = aws_s3_bucket.bucket.id
  s3_key    = aws_s3_object.lambda_zip.key

  source_code_hash = filebase64sha256("app.py.zip")# To ensure that Lambda is updated when the local file changes
  
}