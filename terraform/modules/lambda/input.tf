variable "project" {
  type        = string
  default     = "proj"
  description = "Project name"
}
variable "env" {
  type        = string
  default     = "dev"
  description = "Environment name"
}
variable "vpc_id" {
  type = string
  description = "Vpc id"
}
variable "subnet_id" {
  type = string
  description = "Subnet id"
}
variable "lambda_function_name" {
    type = string
    description = "Lambda function name"
}
variable "lambda_handler_name" {
  type = string
  description = "Lambda function handler name"
}
variable "lambda_function_runtime" {
    type = string
    default = "python3.9"
    description = "Lambda function runtime e.g python3.9"
  
}
variable "lambda_max_memory" {
  type = number
  default = 128
  description = "Amount of Memory in MBs your Lambda Function can use at runtime"
}
variable "lambda_timeout" {
  type = number
  default = 3
  description = "Amount of time your Lambda Function has to run in seconds."
}
/* variable "lambda_code_s3_bucket" {
    type = string
    description = "Lambda function code zip s3 bucket"
} */
variable "lambda_deployment_package_path" {
    type = string
    description = "Lambda function code zip local path"
}
variable "lambda_env_variables" {
  type        = map(string)
  default     = {}
  description = "(Optional) A map of environment variables to pass to the Lambda function."

}

variable "tags" {
  type = map(string)
  description = "Tags to attach to resources"
}