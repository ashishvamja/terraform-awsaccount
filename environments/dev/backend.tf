terraform {
  backend "s3" {
    bucket         = "demo-account-tfstate"
    dynamodb_table = "terraform-locks"
    encrypt        = true
    key            = "environments/dev/terraform.tfstate"
    region         = "us-east-1"
  }
}
