
## Provsioning infra in AWS Cloud using Terraform

This repo contains 3 different environments and it creates bastion host to access EKS worker nodes. 

 * VPC 
 * Ec2 instance
 * RDS 
 * EKS Cluster

## Prerequisite

* This terraform code was tested on v1.0.0 and anything above >= 0.15.5 will work.

* Install AWS Cli and configure the keys 

* All resources will be provision on `ap-southeast-1`

To provision resources clone the repository and run `terraform apply` in any of the environment.


```

## Run below command after provisioning resources

```aws eks --region ap-southeast-1 update-kubeconfig --name $cluster-name```

