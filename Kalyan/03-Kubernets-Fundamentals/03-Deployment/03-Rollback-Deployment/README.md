### 03-Rollback-Deployment Introduction
- We can rollback a deployment in two ways.
    - **Previous Version**
    - **Specific Version**

# Rollback a Deployment to `previous version`

Check the Rollout History of a Deployment

```t
# List Deployment Rollout History
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment  
```
Verify changes in each revision
- **Observation:** Review the "Annotations" and "Image" tags for clear understanding about changes.
```t
# List Deployment History with revision information
kubectl rollout history deployment/my-first-deployment --revision=1
kubectl rollout history deployment/my-first-deployment --revision=2
kubectl rollout history deployment/my-first-deployment --revision=3
```
Rollback to previous version

- **Observation:** If we rollback, it will go back to revision-2 and its number increases to revision-4

```t
# Undo Deployment
kubectl rollout undo deployment/my-first-deployment

# List Deployment Rollout History
kubectl rollout history deployment/my-first-deployment  
```
Verify Deployment, Pods, ReplicaSets
```t
kubectl get deploy
kubectl get rs
kubectl get po
kubectl describe deploy my-first-deployment
```
Access the Application using Public IP

- We should see `Application Version:V2` whenever we access the application in browser

```t
# Get NodePort
kubectl get svc
Observation: Make a note of port which starts with 3 (Example: 80:3xxxx/TCP). Capture the port 3xxxx and use it in application URL below. 

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
Observation: Make a note of "EXTERNAL-IP" if your Kubernetes cluster is setup on AWS EKS.

# Application URL
http://<worker-node-public-ip>:<Node-Port>
```

# Rollback to specific revision

Check the Rollout History of a Deployment

```t
# List Deployment Rollout History
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment 
```

Rollback to specific revision

```t
# Rollback Deployment to Specific Revision
kubectl rollout undo deployment/my-first-deployment --to-revision=3
```

List Deployment History

**Observation:** If we rollback to revision 3, it will go back to revision-3 and its number increases to revision-5 in rollout history

```t
# List Deployment Rollout History
kubectl rollout history deployment/my-first-deployment  
```

# Access the Application using Public IP

- We should see `Application Version:V3` whenever we access the application in browser

```t
# Get NodePort
kubectl get svc
*Observation:* Make a note of port which starts with 3 (Example: 80:3xxxx/TCP). Capture the port 3xxxx and use it in application URL below. 

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
Observation: Make a note of "EXTERNAL-IP" if your Kubernetes cluster is setup on AWS EKS.

# Application URL
http://<worker-node-public-ip>:<Node-Port>

```
# Rolling Restarts of Application

Check the Rollout History of a Deployment

```t
# List Deployment Rollout History
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment 

# Get list of Pods
kubectl get po

```
