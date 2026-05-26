terraform {
  backend "s3" {
    bucket = "acme-grc-evidence-846470648858"
    key    = "terraform/state/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
