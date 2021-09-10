data "aws_region" "aws-region" {}

locals {
  tags = {
    "Application Service Number" = "1223"
    "Business Application Number" = "678"
    "Application Name" = "Victor"
    "Environment name" = "cert"
  }
  lambda_env_vars = {}
  
}

terraform {
  backend "s3" {
    bucket         = "proj-dev-tf-backend-us-west-2-193526802725"
    key            = "tf-state/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "proj-dev-tf-lock-us-west-2"
    encrypt        = true
  }
}


module "s3_bucket" {
  source              = "../../modules/s3/"
  project             = var.project
  env                 = "${terraform.workspace}"
  s3_bucket_name      = "${var.project}-${terraform.workspace}-cloudfront-${data.aws_region.aws-region.name}"
  s3_logs_bucket_name = "${var.project}-${terraform.workspace}-cf-logs-${data.aws_region.aws-region.name}"
  s3_versioning       = true
  tags                = local.tags

}
module "cloudfront" {
  source                         = "../../modules/cloudfront"
  depends_on                     = [module.s3_bucket]
  project                        = var.project
  env                            = "${terraform.workspace}"
  s3_domain_bucket_name          = module.s3_bucket.s3_bucket
  is_ipv6_enabled                = true
  default_root_object            = "index.html"
  logging_bucket                 = module.s3_bucket.s3_logs_bucket
  s3_bucket_log_prefix           = "cf-logs"
  cookies_in_logs                = true
  cf_alias                       = ""
  forward_query_string_to_origin = false
  forward_header_to_origin       = []
  cokkies_to_forward             = "all"
  whitelisted_cookies_to_forward = [""]
  viewer_protocol_policy         = "redirect-to-https"
  min_ttl                        = 0
  default_ttl                    = 3600
  max_ttl                        = 86400
  price_class                    = "PriceClass_200"
  geo_restriction_type           = "none"
  geo_locations                  = [""]
  acm_certificate_arn            = ""
  tags                           = local.tags
  
}

module "lambda_function" {
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = "vpc-d53b0ead"
  subnet_id                      = "subnet-7d870105"
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "python3.9"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}