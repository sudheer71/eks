## Create EKS Cluster & Node Groups
Introduction
- Understand about EKS Core Objects [Core Objects Detailed](https://github.com/sudheermuthyala/EKS/tree/main/01-EKS-Create-Cluster-using-eksctl/01-02-Create-EKSCluster-and-NodeGroups#eks-cluster--core-objects-detailed)
    - Control Plane
    - Worker Nodes & Node Groups
    - Fargate Profiles
    - VPC
- Create EKS Cluster [Create cluster using eksctl](https://github.com/sudheermuthyala/EKS/tree/main/01-EKS-Create-Cluster-using-eksctl/01-02-Create-EKSCluster-and-NodeGroups#create-eks-cluster)
- Associate EKS Cluster to IAM OIDC Provider [Open ID connect Provider](https://github.com/sudheermuthyala/EKS/tree/main/01-EKS-Create-Cluster-using-eksctl/01-02-Create-EKSCluster-and-NodeGroups#create--associate-iam-open-id-connect-provider-oidc-provider-for-our-eks-cluster)
- Create EC2 Keypair [creating Keypair](https://github.com/sudheermuthyala/EKS/tree/main/01-EKS-Create-Cluster-using-eksctl/01-02-Create-EKSCluster-and-NodeGroups#create-ec2-keypair)
- Create EKS Node Groups
- Verify Cluster, Node Groups, EC2 Instances, IAM Policies and Node Groups

## AWS EKS – Core Objects 
EKS Cluster
- **EKS Control Plane :** Contains Kubernetes Master components like **etcd**, **kube-apiserver**, **kube-controller**.
It’s a managed service by AWS
- **Worker Nodes & Node Groups :** Group of EC2 Instances where we run our Application workloads

- **Fargate Profiles (Serverless) :** Instead of EC2 Instances, we run our Application workloads on Serverless Fargate profiles
- **VPC :** With AWS VPC we follow secure networking standards which will allow us to run production workloads on EKS. 
<p align="center">
  <img src="https://github.com/sudheermuthyala/EKS/blob/main/Img/2023-03-01-14-25-56.png" />
    </p>

## EKS Cluster – Core Objects Detailed
- **EKS Control Plane :** 
    1. EKS runs a single tenant Kubernetes control plane for each cluster, and control plane infrastructure is not shared across clusters or AWS accounts.
    2. This control plane consists of at least two API server nodes and three etcd nodes that run across three Availability Zones within a Region
    3. EKS automatically detects and replaces unhealthy control plane instances, restarting them across the Availability Zones within the Region as needed.

- **Worker Nodes & Node Groups :**
    1. Worker machines in Kubernetes are called nodes.  These are EC2 Instances
    2. EKS worker nodes run in our AWS account and connect to our cluster's control plane via the cluster API server endpoint. 
    3. A node group is one or more EC2 instances that are deployed in an EC2 Autoscaling group. 
    4. All instances in a node group must 
        1. Be the same instance type
        2. Be running the same AMI
        3. Use the same EKS worker node IAM role 
- **Fargate Profiles :**
    1. AWS Fargate is a technology that provides on-demand, right-sized compute capacity for containers
    2. With Fargate, we no longer have to provision, configure, or scale groups of virtual machines to run containers. 
    3. Each pod running on Fargate has its own isolation boundary and does not share the underlying kernel, CPU resources, memory resources, or elastic network interface with another pod.
    4. AWS specially built Fargate controllers that recognizes the pods belonging to fargate and schedules them on Fargate profiles. 
- **VPC :**
    1. EKS uses AWS VPC network policies to restrict traffic between control plane components to within a single cluster. 
    2. Control plane components for a EKS cluster cannot view or receive communication from other clusters or other AWS accounts, except as authorized with Kubernetes RBAC policies. 
    3. This secure and highly-available configuration makes EKS reliable and recommended for production workloads.


## Create EKS Cluster using eksctl
- It will take 15 to 20 minutes to create the Cluster Control Plane
- **NOTE :** Hear I'm creating with out nodegroup

## Creating Control Plane Only
```t
# Create Cluster 
eksctl create cluster --name=mseks \
                      --region=us-east-1 \
                      --zones=us-east-1a,us-east-1b \
                      --without-nodegroup 

# Get List of clusters
eksctl get cluster       

# List Nodes in current kubernetes cluster 
kubectl get nodes
```



## Create & Associate IAM `Open ID Connect Provider` (OIDC) Provider for our EKS Cluster 
- To enable and use AWS IAM roles for Kubernetes service accounts on our EKS cluster, we must create & associate OIDC identity provider.
- To do so using `eksctl` we can use the below command.
- using eksctl version (as on today the latest version is 0.131.0)

```t
# Template
eksctl utils associate-iam-oidc-provider \
    --region <region-code> \
    --cluster <cluter-name> \
    --approve


# Replace with region & cluster name
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster mseks \
    --approve

```
## Create EC2 Keypair
- Create a new EC2 Keypair with name as `eks`
- This keypair we will use it when creating the EKS NodeGroup
- This will help us to login to the EKS Worker Nodes using Terminal

## Create Node Group with additional Add-Ons in Public Subnets
- These add-ons will create the respective IAM policies for us automatically within our Node Group role

## Create Node Group separately
```t
# Template 
# Create Public Node Group   
eksctl create nodegroup --cluster= <cluster-name>\
                       --region=us-east-1 \
                       --name=-<ng-public1> \
                       --node-type=t3.medium \
                       --nodes=2 \
                       --nodes-min=2 \
                       --nodes-max=4 \
                       --node-volume-size=20 \
                       --ssh-access \
                       --ssh-public-key=<eks> \
                       --managed \
                       --asg-access \
                       --external-dns-access \
                       --full-ecr-access \
                       --appmesh-access \
                       --alb-ingress-access 



# Create Public Node Group   
## Replacing with --cluster & --name & --ssh-public-key
eksctl create nodegroup --cluster=mseks \
                       --region=us-east-1 \
                       --name=mseks-ng-public1 \
                       --node-type=t3.medium \
                       --nodes=2 \
                       --nodes-min=2 \
                       --nodes-max=4 \
                       --node-volume-size=20 \
                       --ssh-access \
                       --ssh-public-key=eks \
                       --managed \
                       --asg-access \
                       --external-dns-access \
                       --full-ecr-access \
                       --appmesh-access \
                       --alb-ingress-access 

```

## Verify Cluster & Nodes
Verify NodeGroup subnets to confirm EC2 Instances are in Public Subnet
- Verify the node group subnet to ensure it created in public subnet
    - Go to Services -> EKS -> mseks -> compute ->  in Node groups , `mseks-ng-public1` 
    - Click on Associated subnet in Details tab
    - Click on Route Table Tab.
    - We should see that internet route via Internet Gateway (0.0.0.0/0 -> igw-xxxxxxxx)

## List Worker Nodes

```t
# List EKS clusters
eksctl get cluster

# List NodeGroups in a cluster
eksctl get nodegroup --cluster=<clusterName>

# List Nodes in current kubernetes cluster
kubectl get nodes -o wide

# Our kubectl context should be automatically changed to new cluster
kubectl config view --minify
```

## Verify Worker Node IAM Role and list of Policies
- Go to Services -> EC2 -> Worker Nodes
- Click on **IAM Role associated to EC2 Worker Nodes**

## Verify Security Group Associated to Worker Nodes
- Go to Services -> EC2 -> Worker Nodes
- Click on **Security Group** associated to EC2 Instance which contains `remote` in the name.

## Verify CloudFormation Stacks
- Verify Control Plane Stack & Events
- Verify NodeGroup Stack & Events

## Login to Worker Node using Keypai kube-demo
- Login to worker node 
```t
# For  Linux
ssh -i kube-demo.pem ec2-user@<Public-IP-of-Worker-Node>
```

## Update Worker Nodes Security Group to allow all traffic
- We need to allow `All Traffic` on worker node security group 

##  Additional References
- https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
- https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html


## **NOTE :** Hear we are creating control plain and node group separately to know what is Happening in Backend
