## eksctl commands List 

# Create a cluster
- eksctl create cluster 
 
```t
## Example
eksctl create cluster --name=mseks \
                      --region=us-east-1 \
                      --zones=us-east-1a,us-east-1b \
                      --without-nodegroup 

## Get List of clusters
eksctl get cluster

# Replace with region & cluster name
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster mseks \
    --approve

# Create Public Node Group
eksctl create nodegroup --cluster=mseks \
                       --region=us-east-1 \
                       --name=mseks-ng-public1 \
                       --node-type=t3.medium \
                       --nodes=2 \
                       --nodes-min=2 \
                       --nodes-max=4 \
                       --node-volume-size=20 \
                       --ssh-access \
                       --ssh-public-key=k8s \
                       --managed \
                       --asg-access \
                       --external-dns-access \
                       --full-ecr-access \
                       --appmesh-access \
                       --alb-ingress-access 
```
# Delete a cluster
```t
## Example
eksctl delete cluster <Cluster-Name>
eksctl delete cluster mseks
```

# Get List of clusters
```t
eksctl get cluster    
```

# Help
```t
eksctl create cluster --help
eksctl create --help
eksctl create nodegroup --help
```

