output "github_grc_gate_role_arn" {
  description = "ARN of the IAM role assumed by GitHub Actions"
  value       = aws_iam_role.github_grc_gate.arn
}
