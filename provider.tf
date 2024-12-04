provider "aws" {
  shared_config_files      = ["/Users/nhannguyenh/Documents/myws/PracticalDevOps/terraform/.aws/config"]
  shared_credentials_files = ["/Users/nhannguyenh/Documents/myws/PracticalDevOps/terraform/.aws/credentials"]

  region = var.aws_region
}