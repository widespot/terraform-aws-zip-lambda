variable "lambda_name" {
  type        = string
  description = "Name of the lambda function. Must be unique in the region"
}

variable "source_path" {
  type = string
  description = "Path to the directory to zip. Archive must be less than XX"
}

variable "source_main_file" {
  type        = string
  default     = "handler"
  description = "Name of the file, without extension, in the source_path directory to execute as entrypoint. Default is handler for handler.js"
}

variable "source_handler_function" {
  type        = string
  default     = "handler"
  description = "name of the handler function in the source_main_file. "
}

variable "zip_name" {
  type        = string
  default     = null
  description = "Name of the zip archive, including extension. Default is `{var.lambda_name}.zip`"
}

variable "timeout" {
  type        = number
  default     = 3
  description = "Lambda timeout, in seconds"
}
