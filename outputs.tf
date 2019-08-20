# Output EC2 instance URL from the app module
output "url" {
  value = "${module.nginx_s3_app.url} - (it can take 1-2 minutes)"
}
