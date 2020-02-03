provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "fdns-terraform-state"
    key    = "cloud-account"
    region = "us-east-2"
  }
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
}
