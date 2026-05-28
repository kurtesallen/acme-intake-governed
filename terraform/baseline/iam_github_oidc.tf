variable "github_repo" {
  type    = string
  default = "kurtesallen/acme-intake-governed-v2"
}

# ---------------------------------------------------------
# GitHub OIDC Provider (REMOVED — already exists in AWS)
# ---------------------------------------------------------
# Terraform will NOT manage the provider.
# The trust policy will reference the existing provider ARN.
# ---------------------------------------------------------

data "aws_iam_openid_connect_provider" "github" {
  arn = "arn:aws:iam::846470648858:oidc-provider/token.actions.githubusercontent.com"
}

# ---------------------------------------------------------
# IAM Role for GitHub GRC Gate
# ---------------------------------------------------------
resource "aws_iam_role" "github_grc_gate" {
  name = "GitHubGrcGateRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = data.aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_repo}:*"
          }
        }
      }
    ]
  })
}

# ---------------------------------------------------------
# IAM Policy for GRC Gate
# ---------------------------------------------------------
resource "aws_iam_policy" "github_grc_gate_policy" {
  name        = "GitHubGrcGatePolicy"
  description = "Permissions for GitHub GRC Gate workflow"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3Evidence"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::acme-grc-evidence-846470648858",
          "arn:aws:s3:::acme-grc-evidence-846470648858/*"
        ]
      },
      {
        Sid    = "KmsSign"
        Effect = "Allow"
        Action = [
          "kms:Sign",
          "kms:DescribeKey"
        ]
        Resource = var.evidence_signing_key_arn
      },
      {
        Sid    = "TerraformRead"
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "iam:GetRole",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:GetPolicy",
          "iam:GetPolicyVersion"
        ]
        Resource = "*"
      }
    ]
  })
}

# ---------------------------------------------------------
# Attach Policy to Role
# ---------------------------------------------------------
resource "aws_iam_role_policy_attachment" "github_grc_gate_attach" {
  role       = aws_iam_role.github_grc_gate.name
  policy_arn = aws_iam_policy.github_grc_gate_policy.arn
}
