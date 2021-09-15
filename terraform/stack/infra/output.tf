output "vpc_id" {
    value = module.vpc.vpc_id
}
output "vpc_public_subnets" {
    value = module.vpc.public_subnets
}
output "vpc_private_subnets" {
    value = module.vpc.private_subnets
}
output "s3Bucket" {
    value = module.s3_bucket.s3_bucket
}
output "cloudfrontDNS" {
    value = module.cloudfront.cloudfront_dns
}
output "lambda_getlookupdata" {
    value = module.lambda_getlookupdata.lambda_function_arn
}
output "lambda_getchargetypes" {
    value = module.lambda_getchargetypes.lambda_function_arn
}
output "lambda_deletehoachargeitem" {
    value = module.lambda_deletehoachargeitem.lambda_function_arn
}
output "lambda_gethoacharge" {
    value = module.lambda_gethoacharge.lambda_function_arn
}
output "lambda_getindividualhoacharge" {
    value = module.lambda_getindividualhoacharge.lambda_function_arn
}
output "lambda_updatehoadues" {
    value = module.lambda_updatehoadues.lambda_function_arn
}
output "lambda_updatehoaentity" {
    value = module.lambda_updatehoaentity.lambda_function_arn
}
output "lambda_updatehoaproration" {
    value = module.lambda_updatehoaproration.lambda_function_arn
}
output "lambda_createhoacharge" {
    value = module.lambda_createhoacharge.lambda_function_arn
}
output "lambda_createhoachargeitem" {
    value = module.lambda_createhoachargeitem.lambda_function_arn
}
output "lambda_updatehoachargeitem" {
    value = module.lambda_updatehoachargeitem.lambda_function_arn
}
output "lambda_createsigningorder" {
    value = module.lambda_createsigningorder.lambda_function_arn
}
output "lambda_getpropertyaddress" {
    value = module.lambda_getpropertyaddress.lambda_function_arn
}
output "lambda_deletesigningorder" {
    value = module.lambda_deletesigningorder.lambda_function_arn
}
output "lambda_getsigningorder" {
    value = module.lambda_getsigningorder.lambda_function_arn
}
output "lambda_signingorderlist" {
    value = module.lambda_signingorderlist.lambda_function_arn
}
output "lambda_updatesigningorder" {
    value = module.lambda_updatesigningorder.lambda_function_arn
}
