module "baseline" {
  source      = "../../baseline"
  region      = "us-east-1"
  environment = "prod"

  tags = {
    Owner       = "ACME"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}
