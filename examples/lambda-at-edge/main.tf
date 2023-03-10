module "lambda" {
  source = "../../"


  lambda_name = "test-edge"
  source_path = "../javascript-lambda"

  entrypoint_file = "async-handler"

  edge_permissions = true
}

provider "aws" {
  # Lambda @ Edge must be deployed in US-East-1
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/edge-functions-restrictions.html
  region = "us-east-1"
}
