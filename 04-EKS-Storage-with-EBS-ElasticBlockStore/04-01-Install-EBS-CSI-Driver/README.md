# EKS Storage with EBS - Elastic Block Store
1. Introduction
2. Create IAM policyy
3. Get the IAM role Worker Nodes using and Associate this policy to that role
4. Deploy Amazon EBS CSI Driver

##  Step-01: Introduction
- Create IAM Policy for EBS
- Associate IAM Policy to Worker Node IAM Role
- Install EBS CSI Driver
## Step-02: Create IAM policyy
- Go to Services -> IAM
- Create a Policy
    - Select JSON tab and copy paste the below JSON

```t

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteSnapshot",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DescribeInstances",
        "ec2:DescribeSnapshots",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume"
      ],
      "Resource": "*"
    }
  ]
}
```
- Review the same in Visual Editor
- Click on **Review Policy**
- **Name:** Amazon_EBS_CSI_Driver
- **Description:** Policy for EC2 Instances to access Elastic Block Store
- Click on **Create Policy**

**NOTE :** 

- So once we create this role and then associate it to our EBS EC2 instances,things like EKS EC2 instances worker node IAM role,which means like the pods inside the Kubernetes will be able to access
that respective EBS services from the Kubernetes cluster.



## Step-03: Get the IAM role Worker Nodes using and Associate this policy to that role
```t
# Get Worker node IAM Role ARN
kubectl -n kube-system describe configmap aws-auth

# from output check rolearn
rolearn: arn:aws:iam::180789647333:role/eksctl-eksdemo1-nodegroup-eksdemo-NodeInstanceRole-IJN07ZKXAWNN
```
- Go to Services -> **IAM** -> Roles
- Search for role with name **eksctl-eksdemo1-nodegroup** and open it
- Click on **Permissions** tab
- Click on **Attach Policies**
- Search for **Amazon_EBS_CSI_Driver** and click on **Attach Policy**

Step-04: Deploy Amazon EBS CSI Driver

- Verify kubectl version, it should be 1.14 or later
```
kubectl version --client --short
```
- Deploy Amazon EBS CSI Driver
```t
# Deploy EBS CSI Driver
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

# Verify ebs-csi pods running
kubectl get pods -n kube-system
```