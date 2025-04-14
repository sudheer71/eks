# AWS EKS Storage EBS CSI Driver
![image](https://github.com/sudheermuthyala/EKS/assets/34484660/45ded0c7-1e8b-4f1f-ba3a-5413626adc2b)


# AWS Elastic Block Store - Introduction

- EBS provides block level storage volumes for use with EC2 & Container instances.
- We can mount these volumes as devices on our EC2 & Container instances. 
- EBS volumes that are attached to an instance are exposed as storage volumes that persist independently from the life of the EC2 or Container instance.
- We can dynamically change the configuration of a volume attached to an instance.
- AWS recommends EBS for data that must be quickly accessible and requires long-term persistence. 
- EBS is well suited to both database-style applications that rely on random reads and writes, and to throughput-intensive applications that perform long, continuous reads and writes.

![image](https://github.com/sudheermuthyala/EKS/assets/34484660/a8d2547d-d970-4eb8-b439-bb6d95766c34)


<p align="center">
    <img src="" />
</p>


## AWS EBS CSI Driver
- We are going to use EBS CSI Driver and use EBS Volumes for persistence storage to MySQL Database

## Topics
1. Install EBS CSI Driver
2. Create MySQL Database Deployment & ClusterIP Service
3. Create User Management Microservice Deployment & NodePort Service

## Concepts
| Kubernetes Object  | YAML File |
| ------------- | ------------- |
| Storage Class  | 01-storage-class.yml |
| Persistent Volume Claim | 02-persistent-volume-claim.yml   |
| Config Map  | 03-UserManagement-ConfigMap.yml  |
| Deployment, Environment Variables, Volumes, VolumeMounts  | 04-mysql-deployment.yml  |
| ClusterIP Service  | 05-mysql-clusterip-service.yml  |
| Deployment, Environment Variables  | 06-UserManagementMicroservice-Deployment.yml  |
| NodePort Service  | 07-UserManagement-Service.yml  |



## References:
- **Dynamic Volume Provisioning:** https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/deploy/kubernetes/overlays/stable
- https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/examples/kubernetes/dynamic-provisioning
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/deploy/kubernetes/overlays/stable
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver
- **Legacy: Will be deprecated** 
  - https://kubernetes.io/docs/concepts/storage/storage-classes/#aws-ebs
  - https://docs.aws.amazon.com/eks/latest/userguide/storage-classes.html

