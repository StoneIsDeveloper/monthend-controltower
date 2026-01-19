terraform {
  backend "s3" {
    bucket         = "monthend-controltower-dev-tf-state"
    key            = "monthend-controltower/dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "monthend-controltower-dev-tf-locks"
    encrypt        = true
  }
}
