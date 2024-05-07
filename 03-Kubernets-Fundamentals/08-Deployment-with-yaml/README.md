## Deployments with YAML
# Step-01: Copy templates from ReplicaSet
- Copy templates from ReplicaSet and change the kind: Deployment
- Update Container Image version to 3.0.0
- Update NodePort service nodePort: 31233
- Change all names to Deployment
- Change all labels and selectors to myapp3