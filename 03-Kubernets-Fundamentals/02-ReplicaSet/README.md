## Kubernetes - ReplicaSets
Introduction to ReplicaSets 
- What are ReplicaSets?
    - A ReplicaSet’s purpose is to maintain a stable set of replica Pods running at any given time.
    - If our application crashes (any pod dies), replicaset will recreate the pod immediately to ensure the configured number of pods running at any given time. 


- What is the advantage of using ReplicaSets?
    - **High Availability or Reliability :**
        - A ReplicaSet’s purpose is to maintain a stable set of replica Pods running at any given time
        - If our application crashes (any pod dies), replicaset will recreate the pod immediately to ensure the configured number of pods running at any given time.
    - **Scaling :**
        - When load become too much for the number of existing pods, Kubernetes enables us to easily scale up our application, adding additional pods as needed.
        - This is going to be seamless and super quick.
    - **Load Balancing :**
        - To avoid overloading of traffic to single pod we can use `load balancing`. 
        - Kubernetes provides pod load balancing out of the box using Services  for the pods which are part of a ReplicaSet
    - **Labels & Selectors :**
        - `Labels & Selectors` are the key items which ties all 3 together (Pod, ReplicaSet & Service), we will know in detail when we are writing YAML manifests for these objects

- How to scale the application 
    - First thing is go ahead and then update your ReplicaSets,number of replicas and decide number,how much you want, and then apply that.
    - You can use kubectl scale to do that.
    -  you can even enable the HorizontalPodAutoscaler to auto scale the pods to achieve to support the amount of traffic spike at that point of time.

<p align="center">
    <img src="https://user-images.githubusercontent.com/34484660/253736877-549921cc-efe2-4579-9ab9-ffbe22775b18.png" />
</p>



## Create ReplicaSet
- Create ReplicaSet

```t
## Create ReplicaSet
kubectl create -f replicaset-demo.yaml
```
- replicaset-demo.yml
```t
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-helloworld-rs
  labels:
    app: my-helloworld
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-helloworld
  template:
    metadata:
      labels:
        app: my-helloworld
    spec:
      containers:
      - name: my-helloworld-app
        image: stacksimplify/kube-helloworld:1.0.0
```
List ReplicaSets
- Get list of ReplicaSets

```t
kubectl get replicaset
kubectl get rs
```
Describe ReplicaSet
- Describe the newly created ReplicaSet

```t
kubectl describe rs/<replicaset-name>

kubectl describe rs/my-helloworld-rs
[or]
kubectl describe rs my-helloworld-rs
```
List of Pods
- Get list of Pods
```t
#Get list of Pods
kubectl get pods
kubectl describe pod <pod-name>

# Get list of Pods with Pod IP and Node in which it is running
kubectl get pods -o wide
```
Verify the Owner of the Pod
- Verify the owner reference of the pod.
- Verify under "name" tag under "ownerReferences". We will find the replicaset name to which this pod belongs to

```t
kubectl get pods <pod-name> -o yaml
kubectl get pods my-helloworld-rs-c8rrj -o yaml 
```
## Expose ReplicaSet as a Service
- Expose ReplicaSet with a service (NodePort Service) to access the application externally (from internet)

```t
# Expose ReplicaSet as a Service
kubectl expose rs <ReplicaSet-Name>  --type=NodePort --port=80 --target-port=8080 --name=<Service-Name-To-Be-Created>
kubectl expose rs my-helloworld-rs  --type=NodePort --port=80 --target-port=8080 --name=my-helloworld-rs-service

# Get Service Info
kubectl get service
kubectl get svc

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
```
- Access the Application using Public IP

```t
http://<node1-public-ip>:<Node-Port>/hello

```
## Test Replicaset Reliability or High Availability

- Test how the high availability or reliability concept is achieved automatically in Kubernetes
- Whenever a POD is accidentally terminated due to some application issue, ReplicaSet should auto-create that Pod to maintain desired number of Replicas configured to achive High Availability.

```t
# To get Pod Name
kubectl get pods

# Delete the Pod
kubectl delete pod <Pod-Name>

# Verify the new pod got created automatically
kubectl get pods   (Verify Age and name of new pod)
```

## Test ReplicaSet Scalability feature
- Test how scalability is going to seamless & quick
- Update the replicas field in replicaset-demo.yml from 3 to 6.

```t
# Before change
spec:
  replicas: 3

# After change
spec:
  replicas: 6
```
- Update the ReplicaSet

```t
# Apply latest changes to ReplicaSet
kubectl replace -f replicaset-demo.yml

# Verify if new pods got created
kubectl get pods -o wide
```
## Delete ReplicaSet & Service
Delete ReplicaSet
```t
# Delete ReplicaSet
kubectl delete rs <ReplicaSet-Name>

# Sample Commands
kubectl delete rs/my-helloworld-rs
[or]
kubectl delete rs my-helloworld-rs

# Verify if ReplicaSet got deleted
kubectl get rs
```
Delete Service created for ReplicaSet
```t
# Delete Service
kubectl delete svc <service-name>

# Sample Commands
kubectl delete svc my-helloworld-rs-service
[or]
kubectl delete svc/my-helloworld-rs-service

# Verify if Service got deleted
kubectl get svc
```
Pending Concept in ReplicaSet
- We didn't discuss about Labels & Selectors
- This concept we can understand in detail when we are learning to write Kubernetes YAML manifest.
- So we will understand about this during the ReplicaSets-YAML section.

