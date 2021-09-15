data "aws_region" "aws-region" {}

locals {
  tags = {
    "Application Service Number" = "APP0005852"
    "Business Application Number" = "APM0001866"
    "Application Name" = "Ignite"
    "Environment name" = "${terraform.workspace}"
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

module "vpc" {
  source              = "../../modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  az_list             = ["us-west-2a","us-west-2b"]
  vpc_tenancy         =  "default"
  public_subnet_cidr  = ["10.0.1.0/24" , "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.6.0/24" , "10.0.7.0/24"]
  tags                = local.tags
}

# module "s3_bucket" {
#   source              = "../../modules/s3/"
#   project             = var.project
#   env                 = "${terraform.workspace}"
#   s3_bucket_name      = "${var.project}-${terraform.workspace}-cloudfront-${data.aws_region.aws-region.name}"
#   s3_logs_bucket_name = "${var.project}-${terraform.workspace}-cf-logs-${data.aws_region.aws-region.name}"
#   s3_versioning       = true
#   tags                = local.tags

# }
# module "cloudfront" {
#   source                         = "../../modules/cloudfront"
#   depends_on                     = [module.s3_bucket]
#   project                        = var.project
#   env                            = "${terraform.workspace}"
#   s3_domain_bucket_name          = module.s3_bucket.s3_bucket
#   is_ipv6_enabled                = true
#   default_root_object            = "index.html"
#   logging_bucket                 = module.s3_bucket.s3_logs_bucket
#   s3_bucket_log_prefix           = "cf-logs"
#   cookies_in_logs                = true
#   cf_alias                       = ""
#   forward_query_string_to_origin = false
#   forward_header_to_origin       = []
#   cokkies_to_forward             = "all"
#   whitelisted_cookies_to_forward = [""]
#   viewer_protocol_policy         = "redirect-to-https"
#   min_ttl                        = 0
#   default_ttl                    = 3600
#   max_ttl                        = 86400
#   price_class                    = "PriceClass_200"
#   geo_restriction_type           = "none"
#   geo_locations                  = [""]
#   acm_certificate_arn            = ""
#   tags                           = local.tags
  
# }

module "lambda_getlookupdata" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-bizparty-getlookupdata"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_getchargetypes" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-getchargetypes"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_deletehoachargeitem" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-deletehoachargeitem"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_gethoacharge" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-gethoacharge"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_getindividualhoacharge" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-getindividualhoacharge"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_updatehoadues" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-updatehoadues"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_updatehoaentity" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-updatehoaentity"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_updatehoaproration" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-updatehoaproration"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_createhoacharge" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-createhoacharge"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_createhoachargeitem" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-createhoachargeitem"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_updatehoachargeitem" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-chargeprocess-updatehoachargeitem"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_createsigningorder" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-notary-createsigningorder"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_getpropertyaddress" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-notary-getpropertyaddress"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_deletesigningorder" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-notary-deletesigningorder"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_getsigningorder" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-notary-getsigningorder"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
}
module "lambda_signingorderlist" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-notary-signingorderlist"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
module "lambda_updatesigningorder" {
  depends_on                     = [module.vpc]
  source                         = "../../modules/lambda"
  project                        = var.project
  env                            = "${terraform.workspace}"
  vpc_id                         = module.vpc.vpc_id
  subnet_id                      = module.vpc.private_subnets[0]
  lambda_function_name           = "${var.project}-${terraform.workspace}-lambda-mfe-notary-updatesigningorder"
  lambda_handler_name            = "lambda_function.lambda_handler"
  lambda_function_runtime        = "dotnetcore3.1"
  lambda_max_memory              = 500
  lambda_timeout                 = 300
  lambda_deployment_package_path = "../../modules/lambda/lambda_function.zip"
  lambda_env_variables           = local.lambda_env_vars
  tags                           = local.tags
  
}
