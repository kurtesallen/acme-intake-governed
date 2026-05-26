module "baseline" {
  source      = "../../baseline"
  region      = var.region
  environment = var.environment
  tags        = var.tags
}
