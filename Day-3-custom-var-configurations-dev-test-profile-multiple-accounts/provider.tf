provider "aws" {
  profile = "default" 
  ##here dev = defualt profile in provider.tf
  ##defualt region is us-east-1 but we can specify the region here if we want to use a different region
}

provider "aws" {
    
    region = "us-east-1"
    alias = "testenv" 
    profile = "test"
  # calling keys from my local machine test profile credentials 
## test environment provider block##
}

# calling keys from my local machine prod profile credentials 
## prod environment provider block##

provider "aws" {
    
    region = "us-east-1"
    alias = "prod" 
    profile = "prod"
  
}