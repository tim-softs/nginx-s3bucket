#!/bin/bash
# A script that runs the app. It expects certain variables to be set via Terraform interpolation.

# set -e

sudo yum update -y
sudo yum install nginx -y
sudo mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.old
# sudo cat <<__EOF__>/usr/share/nginx/html/index.html
# <h2>Hello , world!</h2>
#
# __EOF__
sudo aws s3 cp s3://"${bucket_name}"/index.html /usr/share/nginx/html/index.html
sudo date >> /usr/share/nginx/html/index.html
sudo service nginx start
