output "s3Bucket" {
    value = module.s3_bucket.s3_bucket
}
output "cloudfrontDNS" {
    value = module.cloudfront.cloudfront_dns
}
output "lambdaArn" {
    value = module.lambda_function.lambda_function_arn
}