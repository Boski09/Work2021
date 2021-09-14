# output "s3Bucket" {
#     value = module.s3_bucket.s3_bucket
# }
# output "cloudfrontDNS" {
#     value = module.cloudfront.cloudfront_dns
# }
# output "lambdaArn" {
#     value = module.lambda_function.lambda_function_arn
# }
output "vpc_id" {
    value = module.vpc.vpc_id
}
output "vpc_public_subnets" {
    value = module.vpc.public_subnets
}
output "vpc_private_subnets" {
    value = module.vpc.private_subnets
}