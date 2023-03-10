variable "lambda_name" {
  type        = string
  description = "Name of the lambda function. Must be unique in the region"
}

variable "source_path" {
  type        = string
  description = "Path to the directory to zip. Archive must be less than XX"
}

variable "entrypoint_file" {
  type        = string
  default     = "handler"
  description = "Name of the file, without extension, in the source_path directory to execute as entrypoint. Default value `handler` stands for handler.js"
}

variable "entrypoint_function" {
  type        = string
  default     = "handler"
  description = "name of the handler function in the `entrypoint_file`. "
}

variable "zip_name" {
  type        = string
  default     = null
  description = "Name of the zip archive, including extension. Default is `$${var.lambda_name}.zip`"
}

variable "timeout" {
  type        = number
  default     = 3
  description = "Lambda timeout, in seconds"
}

variable "runtime" {
  type        = string
  default     = "nodejs18.x"
  description = "Identifier of the function's runtime. See [Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) for valid values."
}

variable "description" {
  type        = string
  default     = null
  description = "Description of what your Lambda Function does."
}

variable "edge_permissions" {
  type        = bool
  default     = false
  description = "Enable extended log permissions for Lambda@Edge function to register log in any region. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/edge-functions-logs.html"
}

variable "role_name" {
  type        = string
  default     = null
  description = "Friendly name of the role. If omitted \"AwsLambda-$${var.lambda_name}\" is used. Maximum 64 characters. Use alphanumeric and '+=,.@-_' characters."
}

variable "role_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the lambda role"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for all resources"
}
