output "kms_key_arn" {
  value = aws_kms_key.baseline.arn
}

output "logging_bucket" {
  value = aws_s3_bucket.logs.id
}

output "cloudtrail_arn" {
  value = aws_cloudtrail.baseline.arn
}

output "evidence_signing_key_arn" {
  value = aws_kms_key.evidence_signing.arn
}
