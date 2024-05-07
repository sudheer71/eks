### Kubernetes – Service - NodePort
* We can expose an application running on a set of PODs using different types of Services available in k8s. 
  * ClusterIP
  * NodePort
  * LoadBalancer


## NodePort Service Introduction
* NodePort Service
  * To access our application outside of k8s cluster, we can use NodePort service. 
  * Exposes the Service on each Worker Node's IP at a static port (nothing but NodePort). 
  * A ClusterIP Service, to which the NodePort Service routes, is automatically created. 
  * Port Range 30000-32767

 <p align="center">
    <img src="https://user-images.githubusercontent.com/34484660/253579395-89f6467f-d76b-4043-b2ed-7c4d082e596b.png" />
 </p>

## Demo - Expose Pod with a Service
- Expose pod with a service (NodePort Service) to access the application externally (from internet)
- **Ports**
  - **ClusterIP (Service port):** Port on which node port service listens in Kubernetes cluster internally
  - **targetPort (container port):** We define container port here on which our application is running. This is Nothing but container port in a pod
  - **Worker NodePort (Randam port Range 30000-32767):** Worker Node port on which we can access our application. 
- **NOTE :** Randam port Range 30000-32767 pick only when we use Imperative way 
```t
# Create  a Pod
kubectl run <desired-pod-name> --image <Container-Image> --generator=run-pod/v1
kubectl run msn-c-pod --image stacksimplify/kubenginx:1.0.0 --generator=run-pod/v1

kubectl run msn-c-pod --image stacksimplify/kubenginx:1.0.0

# Expose Pod as a Service
kubectl expose pod <Pod-Name>  --type=NodePort --port=80 --name=<Service-Name>
kubectl expose pod msn-c-pod  --type=NodePort --port=80 --name=msn-nodeport-service

# Get Service Info
kubectl get service
kubectl get svc

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
```
- **Access the Application using Public IP**

```
http://<node1-public-ip>:<Node-Port>
```

- **Important Note about: target-port**
    -  If target-port is not defined, by default and for convenience, the **targetPort** is set to the same value as the **port** field.

```t
# Below command will fail when accessing the application, as service port (81) and container port (80) are different
kubectl expose pod msn-c-pod  --type=NodePort --port=81 --name=msn-nodeport-service2     

# Expose Pod as a Service with Container Port (--taret-port)
kubectl expose pod msn-c-pod  --type=NodePort --port=81 --target-port=80 --name=msn-nodeport-service3

# Get Service Info
kubectl get service
kubectl get svc

# Get Public IP of Worker Nodes
kubectl get nodes -o wide
```