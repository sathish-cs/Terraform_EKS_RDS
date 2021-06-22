                   

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

## Run below command after provisioning resources

```aws eks --region ap-southeast-1 update-kubeconfig --name $cluster-name```

```kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml```

```kubectl apply -f tutum-app.yaml````

Application is accessbile from bastion server. SSH into bastion server.

Update worker node security group to allow bastion host.

```curl worker-node-primary-private-ip:30001``` 
