# Nginx-S3-APP

Nginx, serving helloWorld index.html originally stored in S3 bucket.
- index.html should survive shutdown/startup cycle
- Nginx can be either pre-installed or setup during startup
- Solution should be consistent and reproducible (no manual steps)

using of some AWS-resources:

* AWS Auto Scaling Group  - to do
* AWS Lambda function - to do
* `AWS S3 bucket`  - done
* `AWS S3 bucket policy`  - not necessary thanks to the IAM policy and IAM role
* `Amazon AMI image`  - done
* `EBS volume`  - done
* `EC2 KeyPair`  - done
* `EC2 instance`  - done
* `IAM policy`  - done
* `IAM role`  - done
* `IAM user` - done


### Prerequisites

1. `AWS`-account with `IAM-user` who has needed rights to work with the necessary resources (paragraph above)

1.  `S3-bucket` with file `index.html`


# How to run

1. Install [Terraform](https://www.terraform.io/).
1. Open `vars.tf`, set the environment variables specified at the top of the file, and fill in any other variables that
   don't have a `default`.
1. Run `terraform get`.
1. Run `terraform plan`.
1. If the plan looks good, run `terraform apply`.
1. After the templates have been applied, Terraform will output a URL. Once the server is up and running (which can
   take 1-2 minutes), visit this URL to test the Nginx-S3 app.

## Cleaning up

To clean up the resources created by these templates, just run `terraform destroy`.


# To Do (preferably until August 23, 2019)


1. Define the `autoscaling group` with a minimum of instances = 1, which automatically creates a new instance, if you force to terminate the old

1. Determine the `lambda-function`, which by event - changing a file `index.html` in a `S3-bucket`, terminates a working instance from autoscaling groups

1. In this way the current `index.html` file will always be displayed  in browser by IP.




