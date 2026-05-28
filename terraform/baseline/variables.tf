variable "environment" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}

variable "evidence_signing_key_arn" {
  type        = string
  description = "ARN of the asymmetric KMS key used for evidence signing"
}
