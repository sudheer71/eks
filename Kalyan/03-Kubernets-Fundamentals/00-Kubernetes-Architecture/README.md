## Kubernets Introduction
* kubernets is a portable, extensible, Open-Source Platform For managing Containerixed Workloads
* **Out of the Box Features**
    * Service discovery and load balancing
    * Storage orchestration
    * Automated rollouts And rollbacks
    * Automatic bin Packing
    * self-healing
    * Secret And Configuration management

##  Kubernetes - Architecture 
- **Master Node**
- **Worker Nodes**
    * **Master Node :**
        - **Container Runtime (Docker) :** 
            * Container Runtime is the underlying software where we run all these Kubernetes components. 
            * We are using Docker, but we have other runtime options like rkt, container-d etc.
        - **Etcd :**
            * Consistent and highly-available key value store used as Kubernetes’ backing store for all cluster data.
            * It stores all the masters and worker node information
        - **Kube-Scheduler :**
            * Scheduler is responsible for `distributing containers` across multiple nodes.
            * It watches for newly created Pods with no assigned node, and selects a node for them to run on
        - **Kube-Apiserver :** 
            * It acts as front end for the Kubernetes control plane. It exposes the Kubernetes API.
            * Command line tools (like kubectl), Users and even Master components (scheduler, controller manager, etcd) and Worker node components like (Kubelet) everything talk with API Server. 
        - **Kube-ControlManager :**
            * Controllers are responsible for noticing and responding when `nodes`, `containers` or `endpoints` go down. They make decisions to bring up new containers in such cases. 
                - **Node Controller :** Responsible for noticing and responding when nodes go down.
                - **Replication Controller :** Responsible for maintaining the correct number of pods for every replication controller object in the system.
                - **Endpoints Controller    :** Populates the Endpoints object (that is, joins Services & Pods)
                - **Service Account & Token Controller :** Creates default accounts and API Access for new namespaces. 
        - **CLoud ControlManager :**
            * A Kubernetes control plane component that embeds cloud-specific control logic. 
            * It only runs controllers that are specific to your cloud provider. 
            * `On-Premise Kubernetes` clusters will not have this component. 
            - **Node controller :** For checking the cloud provider to determine if a node has been deleted in the cloud after it stops responding
            - **Route controller :** For setting up routes in the underlying cloud infrastructure
            - **Service controller :** For creating, updating and deleting cloud provider load balancer

    - **Worker Nodes**
        - **Container Runtime (Docker) :** 
            * Container Runtime is the underlying software where we run all these Kubernetes components. 
            * We are using Docker, but we have other runtime options like rkt, container-d etc.

        - **Kubelet :** 
            * Kubelet is the agent that runs on every node in the cluster
            * This agent is responsible for making sure that containers are running in a Pod on a node.

        - **Kube-Proxy :**
            * It is a network proxy that runs on each node in your cluster.
            * It maintains network rules on nodes 
            * In short, these network rules allow network communication to your Pods from network sessions inside or outside of your cluster.

Kubernetes - Architecture
<p align="center">
    <img src="https://user-images.githubusercontent.com/34484660/252858216-02bed682-bf35-4456-812f-23f7c47d5800.png" />
</p>


EKS Architecture
<p align="center">
    <img src="https://user-images.githubusercontent.com/34484660/252858221-ea0bdeb0-2656-49b1-9e54-343ea29f2bc7.png" />
      </p>


### Kubernetes Fundamentals Pod, ReplicaSet, Deployment & Service
- **k8s Fundamentals**
    * **Pod :**
        * A POD is a single instance of an Application. 
        * A POD is the smallest object, that you can create in Kubernetes. 

    * **ReplicaSet :**
        * A ReplicaSet will maintain a stable set of replica Pods running at any given time. 
        * In short, it is often used to guarantee the availability of a specified number of identical Pods

    * **Deployment :** 
        * A Deployment runs multiple replicas of your application and automatically replaces any instances that fail or become Unresponsive. Rollout & rollback changes to applications. 
        * Deployments are well-suited for stateless applications.

    * **Service :**
        * A service is an abstraction for pods, providing a stable, so called virtual IP (VIP) address.
        * In simple terms, service sits Infront of a POD and acts as a load balancer. 

### Kubernetes - Imperative & Declarative

<p align="center">
    <img src="https://user-images.githubusercontent.com/34484660/252858225-f0f4b095-14fa-4150-8409-8b32c7055e7e.png" />
      </p>


