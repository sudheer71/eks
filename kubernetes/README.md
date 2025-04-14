<p align="center">
    <img src="https://user-images.githubusercontent.com/34484660/253774654-90e595e7-8041-410e-a405-bf7d21d130ff.png" />
</p>

## Kubernetes Concepts


- [Architecture](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/00-Kubernetes-Architecture/README.md#kubernetes---architecture)
- [Pods](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/01-Pod/README.md#kubernetes---pods)
- [ReplicaSets](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/02-ReplicaSet/README.md#kubernetes---replicasets)
- [Deployments](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/03-Deployment/README.md#deployments)
    - [01-CreateDeployment-Scaling-and-Expose-as-Service](https://github.com/sudheermuthyala/EKS/tree/main/03-Kubernets-Fundamentals/03-Deployment#01-createdeployment-scaling-and-expose-as-service)
    - [02-Update-Deployment](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/03-Deployment/02-Update-Deployment/README.md#02-update-deployment)
    - [03-Rollback-Deployment Introduction](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/03-Deployment/03-Rollback-Deployment/README.md#03-rollback-deployment-introduction)
    - [04-Pause-and-Resume-Deployment](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/03-Deployment/04-Pause-and-Resume-Deployment/README.md#04-pause-deployment-and-two-changes)


- [Node Port Service](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/04-Service/README.md#nodeport-service-introduction)
- [Cluster IP Service]()
- [External Name Service]()
- [Ingress Service]()
- [Ingress SSL]()
- [Ingress & External DNS]()
- [kubectl - Imperative]()
- [Declarative with YAML]()
- [Secrets]
- [Init Containers]()
- [Probes]
- [Requests & Limits]()
- [Namespaces]
- [Limit Range]()
- [Resource Quota]()
- [Storage Classes]()
- [Persistent Volumes]()
- [PVC]()
- [Load Balancers]()
- [Annotations]()
- [Canary Deployments]()
- [HPA]()
- [VPA]()
- [DaemonSets]()
- [Fluentd for logs]()
- [ConfigMaps]()


## Doug

- Why services creating acrose the nodes
- what is managed and unmanaged worker nodes
- What is helper Containers or (side- car) 
- stateless applications.
- How you can check which pod is alocated to which worker node 
- what is Restservice Application 
**Ans:**
  - kubectl describe pod <pod-name>
  - check in Events 
  




```
<p align="center">
    <img src="" />
</p>

```

Imperative way


## create commands 

- [Create ReplicaSet](https://github.com/sudheermuthyala/EKS/blob/main/03-Kubernets-Fundamentals/02-ReplicaSet/README.md#create-replicaset)  : kubectl create -f replicaset-demo.yaml

- [create Deployment](https://github.com/sudheermuthyala/EKS/tree/main/03-Kubernets-Fundamentals/03-Deployment#01-createdeployment-scaling-and-expose-as-service) : kubectl create deployment my-first-deployment --image=stacksimplify/kubenginx:1.0.0