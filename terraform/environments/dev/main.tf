module "baseline" {
  source      = "../../baseline"
  region      = "us-east-1"
  environment = "dev"

  tags = {
    Owner       = "ACME"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
