variable "github_repo" {
  type        = string
  description = "GitHub repository allowed to assume the GRC Gate role"
}

variable "evidence_signing_key_arn" {
  type        = string
  description = "ARN of the asymmetric KMS key used for evidence signing"
}
