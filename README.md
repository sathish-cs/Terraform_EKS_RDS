                   

# Infra Provsioning in AWS Cloud




This directory contains 3 different environments and using the same modules to provision resources.

## Prerequisite

* This terraform code was tested on v1.0.0 and anything above >= 0.15.5 will work.

* Install AWS Cli and configure the keys 

* All resources will be provision on `ap-southeast-1`

To provision resources clone the repository and run `terraform apply` in any of the environment.

For example:

```
git@github.com:sathish-cs/pigeonlab_devops.git
cd pigeonlab_devops/staging
terraform init
terraform apply
```
