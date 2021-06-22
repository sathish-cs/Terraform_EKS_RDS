
  # Aurora RDS & EC2




This module will be provision RDS and EC2(Uses Amazon Linux v2) instance. RDS will noth be publicly acessible and it only allow traffic from same VPC. Using bastion server we can access both RDS and EKS worker nodes. SSH Key will be generated on the fly and public will be store on same path where terraform apply command runs.

It will be output the RDS endpoints, username  and bastion host IP.



