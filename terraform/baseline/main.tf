# -----------------------------
# KMS CMK (SC-13 Encryption)
# -----------------------------
resource "aws_kms_key" "baseline" {
  description             = "ACME baseline CMK for encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  tags = merge(var.tags, {
    "Control" = "SC-13"
  })
}

# -----------------------------
# S3 Logging Bucket (AU-2)
# -----------------------------
resource "aws_s3_bucket" "logs" {
  bucket = "acme-${var.environment}-logs-${random_id.suffix.hex}"

  tags = merge(var.tags, {
    "Control" = "AU-2"
  })
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.baseline.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# -----------------------------
# CloudTrail (AU-2)
# -----------------------------
resource "aws_cloudtrail" "baseline" {
  name                          = "acme-${var.environment}-trail"
  s3_bucket_name                = aws_s3_bucket.logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  tags = merge(var.tags, {
    "Control" = "AU-2"
  })
}

# -------------------------------------------------------------------
# Evidence Signing Key (Asymmetric RSA for KMS Sign API)
# -------------------------------------------------------------------
resource "aws_kms_key" "evidence_signing" {
  description         = "Evidence signing key for GRC Gate"
  key_usage           = "SIGN_VERIFY"
  key_spec            = "RSA_2048"
  enable_key_rotation = true

  tags = {
    Name = "evidence-signing-key"
    GRC  = "true"
  }
}
