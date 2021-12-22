provider "aws" {
  profile = "default"
  region = "us-east-1"
  default_tags {
    tags = {
      repository  = "https://github.com/ferlemes/infra-big-bang"
      environment = "develop"
      managed     = "Terraform"
    }
  }
}
