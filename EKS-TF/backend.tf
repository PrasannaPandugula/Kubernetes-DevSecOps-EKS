terraform {
  backend "eks" {
    bucket       = "terraformstatefilestorage1"
    key          = "Kubernetes-DevSecOps-EKS/EKS-TF/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
  }

  required_version = ">=1.13.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.23.0"
    }
  }
}