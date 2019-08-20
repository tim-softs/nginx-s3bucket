variable "name" {
  description = "The name used to namespace resources created by this module"
}

variable "key_pair_name" {
  description = "The name of a Key Pair that you've created in AWS and have saved on your computer. You will be able to use this Key Pair to SSH to the EC2 instance."
}

variable "port" {
  description = "The port the app should listen on for HTTP requests"
}

variable "bucket_name" {
  description = "The bucket with file index.html"
}
