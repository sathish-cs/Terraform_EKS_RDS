
# EKS Cluster 



This module will be provision EKS cluster and its resources like worker node group, IAM roles and security groups. Worker nodes will be lauching on the private subnets. 

It will be output the cluster endpoint and cluster name.


```
 aws eks --region ap-southeast-1 update-kubeconfig --name $cluster-name

```

* Node ports should be open on worker nodes security group(30000-32767) to access the application. Using terraform current not able to attach custom security group to managed node group.


| Port range  | source    |
| :---:       | :-----:   |
| 30000-32767 | 0.0.0.0/0 |
