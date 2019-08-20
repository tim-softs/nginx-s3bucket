# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

# This shows an example of how to use a Terraform module.
module "nginx_s3_app" {
  # The source field can be a path on your file system or a Git URL
  source = "./app-module"

  # Pass parameters to the module
  name          = "Nginx S3 App"
  port          = 80
  key_pair_name = "${var.key_pair_name}"
  bucket_name   = "${var.bucket_name}"

}
