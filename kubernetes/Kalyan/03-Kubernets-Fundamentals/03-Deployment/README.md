## Kubernetes - Deployment

# Deployment
- Deployment is going to be superset of replicaset Which means replicaset can provide a few features.And when we call deployment as a superset,it can provide many,features for us,in addition to what replicaset provides.So that's about the deployment and there is no difference in accessing the applications hosted via replicaset or deployment.the deployment features are as follows,

<p align="center">
    <img src="https://user-images.githubusercontent.com/34484660/253813487-21329bef-245d-4d43-8148-60693132d3ae.png" />
</p>

 
- **Deployments**
    - **Create a Deployment to rollout a ReplicaSet**
        - So we can create a deployment to roll out a replicaset.By default, whenever we create a deployment,a replicaset it is rolled out.
    - **Updating the Deployment**
        - And updating the deployment.So whenever we want to change our application version,update our application version,we can do the update of the deployment.When we do this, automatically our version,whatever we are going to update, it is going to be recorded.So now using that, 

    - **Rolling Back a Deployment**
        - we can easily roll back to our respective older deployment, whatever we want,because it is maintaining the versions.Or if you have updated from V1 to V2, V2 to V3, and then V3 to V4. And now again, if you want to go back to V2, yes,you will be able to go because it maintains the versions, and then version history.
    - **Scaling a Deployment**
        - So now we will be also able to scale our deployments.So how we have done the scaling in replicasets,in the same way in deployment also, we'll have a tag of replicas where we can add the number of replicas.We can add it, or we can use kubectl scale to scale our deployment.

    - **Pausing and Resuming a Deployment**
        - And we can even pause and resume a deployment.So in deployment, the core thing here is, like whenever you apply a change to your deployment,immediately it will be applied to your pods.So that is the thing. So if you want to make multiple changes, then you really don't want the pods to be recreated,or terminated and recreated every second for every change. So you have 10 changes to make to your deployment.Then pause the deployment and make all the changes,and then resume the deployment so that all those changes will be applied to your deployment at a time. So like this, there are multiple things we can take an advantage using the deployment.So whenever you are doing the deployment, 
    - **Deployment Status**
        - you can even get the rollout status or deployment status.

    - **Clean up Policy**
        - Cleanup policy is nothing but So whenever we do the updating of our deployments,it maintains the rollout version history.And by default, it maintains last 10 versions of our application.So we can go to that respective version using that. we will be able to add more number of versions by adding additional tag in our YAML manifest under the spec of the deployment.
    - **Canary Deployments**
        - canary deployments.So if we want to add a new version of our application in the live production traffic,and the traffic should distribute with old version and the new version,still we'll be able to do it using canary deployments.So all these things are available for us with deployment.

## Kubernetes - Deployment Topics

1. Create Deployment
2. Scale the Deployment
3. Expose Deployment as a Service
4. Update Deployment
5. Rollback Deployment
6. Rolling Restarts
7. Pause & Resume Deployments
8. Canary Deployments (Will be covered at Declarative section of Deployments)

## 01-CreateDeployment-Scaling-and-Expose-as-Service
Introduction to Deployments
- What is a Deployment?
- What all we can do using Deployment?
- Create a Deployment
- Scale the Deployment
- Expose the Deployment as a Service

Create Deployment
- Create Deployment to rollout a ReplicaSet
- Verify Deployment, ReplicaSet & Pods
- Docker Image Location: https://hub.docker.com/repository/docker/stacksimplify/kubenginx

```t
# Create Deployment
kubectl create deployment <Deplyment-Name> --image=<Container-Image>
kubectl create deployment my-first-deployment --image=stacksimplify/kubenginx:1.0.0 

# Verify Deployment
kubectl get deployments
kubectl get deploy 

# Describe Deployment
kubectl describe deployment <deployment-name>
kubectl describe deployment my-first-deployment

# Verify ReplicaSet
kubectl get rs

# Verify Pod
kubectl get po
```
Scaling a Deployment
- Scale the deployment to increase the number of replicas (pods)

```t
# Scale Up the Deployment
kubectl scale --replicas=20 deployment/<Deployment-Name>
kubectl scale --replicas=20 deployment/my-first-deployment 

# Verify Deployment
kubectl get deploy

# Verify ReplicaSet
kubectl get rs

# Verify Pods
kubectl get po

# Scale Down the Deployment
kubectl scale --replicas=10 deployment/my-first-deployment 
kubectl get deploy
```

 Expose Deployment as a Service
 - Expose Deployment with a service (NodePort Service) to access the application externally (from internet)

```t
# Expose Deployment as a Service
kubectl expose deployment <Deployment-Name>  --type=NodePort --port=80 --target-port=80 --name=<Service-Name-To-Be-Created>
kubectl expose deployment my-first-deployment --type=NodePort --port=80 --target-port=80 --name=my-first-deployment-service

# Get Service Info
kubectl get svc
Observation: Make a note of port which starts with 3 (Example: 80:3xxxx/TCP). Capture the port 3xxxx and use it in application URL below. 

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
Observation: Make a note of "EXTERNAL-IP" if your Kubernetes cluster is setup on AWS EKS.
```


- Access the Application using Public IP

```t
http://<worker-node-public-ip>:<Node-Port>

```

## ---------------------------------------------------- ##

## 02-Update-Deployment
Kubernetes - Update Deployments Introduction
- We can update deployments using two options
    - Set Image
    - Edit Deployment
## Updating Application version V1 to V2 using "Set Image" Option
Update Deployment
- **Observation:** Please Check the container name in `spec.container.name` yaml output and make a note of it and replace in `kubectl set image` command

```t
# Get Container Name from current deployment
kubectl get deployment my-first-deployment -o yaml

# Update Deployment - SHOULD WORK NOW
kubectl set image deployment/<Deployment-Name> <Container-Name>=<Container-Image> --record=true
kubectl set image deployment/my-first-deployment kubenginx=stacksimplify/kubenginx:2.0.0 --record=true
```

Verify Rollout Status (Deployment Status)
- **Observation:** By default, rollout happens in a rolling update model, so no downtime.
```t
# Verify Rollout Status 
kubectl rollout status deployment/my-first-deployment

# Verify Deployment
kubectl get deploy
```

Describe Deployment
- **Observation:**
    - Verify the Events and understand that Kubernetes by default do "Rolling Update" for new application releases.
    - With that said, we will not have downtime for our application.

```t
# Descibe Deployment
kubectl describe deployment my-first-deployment
```

Verify ReplicaSet
- **Observation:** New ReplicaSet will be created for new version

```t
# Verify ReplicaSet
kubectl get rs
```

Verify Pods
- **Observation:** Pod template hash label of new replicaset should be present for PODs letting us know these pods belong to new ReplicaSet.

```t
# List Pods
kubectl get po
```
Verify Rollout History of a Deployment
- **Observation:** We have the rollout history, so we can switch back to older revisions using revision history available to us.

```t
# Check the Rollout History of a Deployment
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment  
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
## Update the Application from V2 to V3 using "Edit Deployment" Option
Edit Deployment

```t
# Edit Deployment
kubectl edit deployment/<Deployment-Name> --record=true
kubectl edit deployment/my-first-deployment --record=true
```
```yaml
# Change From 2.0.0
    spec:
      containers:
      - image: stacksimplify/kubenginx:2.0.0

# Change To 3.0.0
    spec:
      containers:
      - image: stacksimplify/kubenginx:3.0.0
```
Verify Rollout Status
- **Observation**: Rollout happens in a rolling update model, so no downtime.
```t
# Verify Rollout Status 
kubectl rollout status deployment/my-first-deployment
```
Verify Replicasets
- **Observation:** We should see 3 ReplicaSets now, as we have updated our application to 3rd version 3.0.0
```t
# Verify ReplicaSet and Pods
kubectl get rs
kubectl get po
```
Verify Rollout History
```t
# Check the Rollout History of a Deployment
kubectl rollout history deployment/<Deployment-Name>
kubectl rollout history deployment/my-first-deployment  
```
Access the Application using Public IP
- We should see `Application Version:V3` whenever we access the application in browser

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

#################### 

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
# =========================================================


## Pause & Resume Deployments
# Introduction
- Why do we need Pausing & Resuming Deployments?
    - If we want to make multiple changes to our Deployment, we can pause the deployment make all changes and resume it.
- We are going to update our Application Version from V3 to V4 as part of learning "Pause and Resume Deployments"

## Pausing & Resuming Deployments
# Check current State of Deployment & Application

```t 
# Check the Rollout History of a Deployment
kubectl rollout history deployment/my-first-deployment  
Observation: Make a note of last version number

# Get list of ReplicaSets
kubectl get rs
Observation: Make a note of number of replicaSets present.

# Access the Application 
http://<worker-node-ip>:<Node-Port>
Observation: Make a note of application version

```

# =====================================

## 04-Pause Deployment and Two Changes
# Step-00: Introduction

- Why do we need Pausing & Resuming Deployments?
    - If we want to make multiple changes to our Deployment, we can pause the deployment make all changes and resume it.
- We are going to update our Application Version from **V3** to **V4** as part of learning "Pause and Resume Deployments"

## Step-01: Pausing & Resuming Deployments

Check current State of Deployment & Application

```t
# Check the Rollout History of a Deployment
kubectl rollout history deployment/my-first-deployment  
Observation: Make a note of last version number

# Get list of ReplicaSets
kubectl get rs
Observation: Make a note of number of replicaSets present.

# Access the Application 
http://<worker-node-ip>:<Node-Port>
Observation: Make a note of application version
```

Pause Deployment and Two Changes

```t
# Pause the Deployment
kubectl rollout pause deployment/<Deployment-Name>
kubectl rollout pause deployment/my-first-deployment

# Update Deployment - Application Version from V3 to V4
kubectl set image deployment/my-first-deployment kubenginx=stacksimplify/kubenginx:4.0.0 --record=true

# Check the Rollout History of a Deployment
kubectl rollout history deployment/my-first-deployment  
Observation: No new rollout should start, we should see same number of versions as we check earlier with last version number matches which we have noted earlier.

# Get list of ReplicaSets
kubectl get rs
Observation: No new replicaSet created. We should have same number of replicaSets as earlier when we took note. 

# Make one more change: set limits to our container
kubectl set resources deployment/my-first-deployment -c=kubenginx --limits=cpu=20m,memory=30Mi

```

# Resume Deployment

```t
# Resume the Deployment
kubectl rollout resume deployment/my-first-deployment

# Check the Rollout History of a Deployment
kubectl rollout history deployment/my-first-deployment  
Observation: You should see a new version got created

# Get list of ReplicaSets
kubectl get rs
Observation: You should see new ReplicaSet.

```

## Access Application

```t
# Access the Application 
http://<node1-public-ip>:<Node-Port>
Observation: You should see Application V4 version
```

## Step-02: Clean-Up
```t
# Delete Deployment
kubectl delete deployment my-first-deployment

# Delete Service
kubectl delete svc my-first-deployment-service

# Get all Objects from Kubernetes default namespace
kubectl get all
```