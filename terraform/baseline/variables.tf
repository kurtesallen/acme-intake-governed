variable "region" {
  type        = string
  description = "AWS region for baseline resources"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, prod)"
}

variable "tags" {
  type        = map(string)
  description = "Baseline tags applied to all resources"
  default     = {}
}
