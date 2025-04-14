# EKS Storage - Storage Classes, Persistent Volume Claims

- Step-01: Introduction
- Step-02: Create following Kubernetes manifests
- Step-03: Create MySQL Database with all above manifests
- Step-04: Connect to MySQL Database
- Step-05: References

# Step-01: Introduction
- We are going to create a MySQL Database with persistence storage using AWS EBS Volumes

| Kubernetes Object  | YAML File |
| ------------- | ------------- |
| Storage Class  | 01-storage-class.yml |
| Persistent Volume Claim | 02-persistent-volume-claim.yml   |
| Config Map  | 03-UserManagement-ConfigMap.yml  |
| Deployment, Environment Variables, Volumes, VolumeMounts  | 04-mysql-deployment.yml  |
| ClusterIP Service  | 05-mysql-clusterip-service.yml  |

# Step-02: Create following Kubernetes manifests

## Create Storage Class manifest
- https://kubernetes.io/docs/concepts/storage/storage-classes/#volume-binding-mode
- **Important Note:** Wait For `FirstConsumer` mode will delay the volume binding and provisioning of a PersistentVolume until a Pod using the PersistentVolumeClaim is created.

## Create Persistent Volume Claims manifest
```t
# Create Storage Class & PVC
kubectl apply -f kube-manifests/

# List Storage Classes
kubectl get sc

# List PVC
kubectl get pvc 

# List PV
kubectl get pv
```
## Create ConfigMap manifest
- We are going to create a usermgmt database schema during the mysql pod creation time which we will leverage when we deploy User Management Microservice.
## Create MySQL Deployment manifest
- Environment Variables
- Volumes
- Volume Mounts
## Create MySQL ClusterIP Service manifest
- At any point of time we are going to have only one mysql pod in this design so `ClusterIP: None` will use the `Pod IP Address` instead of creating or allocating a separate IP for `MySQL Cluster IP service`.

# Step-03: Create MySQL Database with all above manifests
```t
# Create MySQL Database
kubectl apply -f kube-manifests/

# List Storage Classes
kubectl get sc

# List PVC
kubectl get pvc 

# List PV
kubectl get pv

# List pods
kubectl get pods 

# List pods based on  label name
kubectl get pods -l app=mysql
```

# Step-04: Connect to MySQL Database
```t
# Connect to MYSQL Database
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -pdbpassword11

# Verify usermgmt schema got created which we provided in ConfigMap
mysql> show schemas;
```
# Step-05: References

- We need to discuss references exclusively here.
- These will help you in writing effective templates based on need in your environments.
- Few features are still in alpha stage as on today (Example:Resizing), but once they reach beta you can start leveraging those templates and make your trials.
- EBS CSI Driver: https://github.com/kubernetes-sigs/aws-ebs-csi-driver
- EBS CSI Driver Dynamic Provisioning: https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/examples/kubernetes/dynamic-provisioning
- EBS CSI Driver - Other Examples like Resizing, Snapshot etc: https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/examples/kubernetes
- k8s API Reference Doc: https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#storageclass-v1-storage-k8s-io


## 01-Storage-class.yml

```t
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ebs-sc
provisioner: ebs.csi.aws.com
VolumeBindingMode: WaitForFirstConsumer

```

**NOTE :**
- `WaitForFirstConsumer` mode will delay the volume binding and provisioning of the persistent volume until a pod using the persistent volume claim is created.
- So what happens is like whenever the storage class you create it and then whenever you create your persistent volume claim. 
- So if you don't add this `VolumeBindingMode` to `WaitForFirstConsumer` then it is going to immediately dynamically provision and then mount your volume.
- So means like it is going to provision your volume there.
- So in which availability zone we really don't know,it is dynamic, whappen So it can be in available zone one or means like US-East-1 here or US-East-1 we really don't know.
- And whenever you go ahead and then later you go and then create the pod what happens is like if your volume is mounted in US-East-1 here and your pod got scheduled or created in US-East-1 B, then you have the issue, right?
- So considering all those things there is a new option provided here `WaitForFirstConsumer` So what happens in this case is like whenever you create the pod at that time only it'll provision the equivalent volume for you.So what happens at that time is both will get created in the same topology which is nothing but in the same a availability zone.
- So that is one key important thing.So that's the reason whenever we are using `WaitForFirstConsumer`