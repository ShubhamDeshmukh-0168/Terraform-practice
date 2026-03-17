resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["sts:AssumeRole"]
      Principal = {
        Service = ["lambda.amazonaws.com"]
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "app.lambda_handler"
  runtime       = "python3.8"

  timeout       = 900
  memory_size   = 128

  filename         = "app.py.zip"
  #source_code_hash = filebase64sha256("app.py.zip") this blocke is used to check if there is any change in the code if there is any change then it will update the lambda function otherwise it will not update the lambda function
  source_code_hash = filebase64sha256("app.py.zip")
}