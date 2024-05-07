### Kubernetes - PODs
PODs Introduction
- What is a POD ?
- What is a Multi-Container POD?

### PODs Demo

## Get Worker Nodes Status
- Verify if kubernetes worker nodes are ready.
```t
# Get Worker Node Status
kubectl get nodes

# Get Worker Node Status with wide option
kubectl get nodes -o wide
```

## Create a Pod Imperative way

- Create a Pod

```t
# Template
kubectl run <desired-pod-name> --image <Container-Image> --generator=run-pod/v1

# Replace Pod Name, Container Image
kubectl run my-first-pod --image stacksimplify/kubenginx:1.0.0 --generator=run-pod/v1

```
- **Important Note :** Without --generator=run-pod/v1 it will create a pod with a deployment
- **Important Note :** With Kubernetes 1.18 version, there is lot clean-up to kubectl run command. The below will suffice to create a Pod as a pod without creating deployment. We dont need to add --generator=run-pod/v1

```
kubectl run my-first-pod --image stacksimplify/kubenginx:1.0.0
```

## List Pods
* Get the list of pods
```t
# List Pods
kubectl get pods

# Alias name for pods is po
kubectl get po
```
## List Pods with wide option
- List pods with wide option which also provide Node information on which Pod is running
```
kubectl get pods -o wide
```
### What happened in the backgroup when above command is run?
1. Kubernetes created a pod
2. Pulled the docker image from docker hub
3. Created the container in the pod
4. Started the container present in the pod

### Describe Pod
- Describe the POD, primarily required during troubleshooting. 
- Events shown will be of a great help during troubleshooting. 
```t
# To get list of pod names
kubectl get pods

# Describe the Pod
kubectl describe pod <Pod-Name>
kubectl describe pod my-first-pod 
```

### Delete Pod
```t
# To get list of pod names
kubectl get pods

# Delete Pod
kubectl delete pod <Pod-Name>
kubectl delete pod my-first-pod
```
## Interact with a Pod
```t
# Get Pod Name
kubectl get po

# Dump Pod logs
kubectl logs <pod-name>
kubectl logs my-first-pod

# stream pod logs with -f option and access application to see logs
kubectl logs -f <pod-name>
kubectl logs -f my-first-pod

```
- Important Notes
    - Refer below link and search for **Interacting with running Pods** for additional log options
    - Troubleshooting skills are very important. So please go through all logging options available and master them.
    - **Reference :** https://kubernetes.io/docs/reference/kubectl/cheatsheet/

## Connect to Container in a POD

- Connect to a Container in POD and execute commands

```t
# Connect to Nginx Container in a POD
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec -it my-first-pod -- /bin/bash

# Execute some commands in Nginx container
ls
cd /usr/share/nginx/html
cat index.html
exit
```

## Running individual commands in a Container
```t
kubectl exec -it <pod-name> env
# Sample Commands
kubectl exec -it my-first-pod env
kubectl exec -it my-first-pod ls
kubectl exec -it my-first-pod cat /usr/share/nginx/html/index.html
```
## Get YAML Output of Pod & Service
Get YAML Output

```t
# Get pod definition YAML output
kubectl get pod my-first-pod -o yaml   

# Get service definition YAML output
kubectl get service my-first-service -o yaml
```
## Clean-Up
```t
# Get all Objects in default namespace
kubectl get all

# Delete Services
kubectl delete svc my-first-service
kubectl delete svc my-first-service2
kubectl delete svc my-first-service3

# Delete Pod
kubectl delete pod my-first-pod

# Get all Objects in default namespace
kubectl get all
```


