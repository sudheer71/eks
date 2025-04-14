Kubernetes pod

- Pods are basic scheduling units in Kubernetes. Pods are often ephemeral in nature
- kubernetes doesn’t run containers directly; instead, it wraps one or more containers  in a high-level structure called a pod
- It is also the smallest deployable unit that can be created, scheduled, and managed on a Kubernetes cluster
- Each pos is assigned to a unique IP address within the cluster
- Pods can hold multiple containers as well, but you should limit yourself when possible because pods are scaled up and down as a unit; all containers in a pod must scale together
- IP address is assigned at the pod level; there is no concept of IP address for a container; it is the IP address of a pod
- pos is like a single VM in the pod containers are in local to each other
- If c1 wants to talk to c2, it uses ports ex: [localhost](http://localhost):80, to reach c2 If c2 wants to talk to c1, it uses localhost:8080.
- This is possible because the pod will create a shared networking namespace; that’s the reason the entire space within the pod acts like a single VM providing common networking for both the containers

**How the eXternal Pods (c3) talk to containers like c1 and c2**

- If c3 wants to talk to c1 or c2, it cannot talk using the [localhost](http://localhost). It can use an IP address of the pod and port for the container, ex: 1.1.1.1:80, and we have services also

**Storage**

- By default, c1 cannot access the data in c2, and vice versa. They can't see each other
- C1 and C2 can share the common storage c4 and create a temp volume in a pod and mount to c1 and c2; then, they can share the common storage; whatever C1 writes in the volume c2 can see it because the c1 and c2 are mounted to common storage volume c4
- Any containers in the same pod can share the same storage volumes and network. resources and communicate [localhost](http://localhost)
- Pods are the units of replication in Kubernetes. If your application becomes too popular and a single pod instance can’t carry the load, Kubernetes can be configured to deploy new replicas of your pod to the cluster as necessary.
- Once the pod is deployed, some data is immutable. You can’t modify the data once the pod is deployed. If you want to change the data, you have to delete the existing pod and apply the new manifest file of the definition file

**Pod Lifecycle** 

- Through its lifecycle, a Pod can attain the following states, starting from Pending to Running
- A Pod's status can be known from the phase field
    - Pending The pod is accepted by the Kubernetes system, but its container(s) is/are not created yet. This includes time a Pod spends waiting to be scheduled as well as the time spent downloading container images over the network.
    - Running: The pod is scheduled on a node and all its containers are created and at-least one container is in Running state
    - Succeeded: All container(s) in the Pod have exited with status 0 and will not be restarted
    - Failed: All container(s) of the Pod have exited and at least one container has returned a non-zero status
    - CrashLoopBackoff: The container fails to start and is tried again and again
    - Unknown: For some reason, the state of the Pod could not be obtained. This phase typically occurs due to an error in communicating with the node where the Pod should be running
    
    ```bash
    kubectl get pod <pod-name> -o yaml | grep phase
    ```
    

- **kubectl -h**
- **kubectl run -h**  Create and run a particular image in a pod.
- **kubectl get pods**
- **kubectl get svc**
- **kubectl get namespace**
- **kubectl get pods,svc,namespace**
- **kubectl get po,svc** —all-namespace All the namespaces
- **kubectl get po,svc** -A [All the namespaces]
- **kubectl get po | grep -i ng** [To get the list of pods nginx]
- **kubectl describe po nginx**
- **kubectl events** [Prints a table of the most important information about events. You can request events for a namespace, for all namespace, or filtered to only those pertaining to a specified resource.]
- **kubectl events -n <namespace-name>**
- **kubectl logs** [Print the logs for a container in a pod or specified resource. If the pod has only one container, the container name is optional]
- **kubectl logs po/nginx [stored logs]**
- **kubectl logs -f po/ngnix [follow-up logs/streamed logs]**
- **kubectl logs -f --timestamps=true po/ngnix**
- **kubectl logs -f —tail=5 --timestamps=true po/ngnix**
- **kubectl logs po/ngnix —all-containers=true**
- **kubectl logs po/nginx -c c1 [container-1]** to get logs from container-1
- **kubectl logs po/nginx -c c2 [container-2]** to get logs from container-2
- **kubectl exec -it po/nginx — sh**
- **kubectl exec -it po/nginx — bash**
- kubectl exec -it po/nginx — hostname
- kubectl exec -it po/nginx — curl [localhost](http://localhost)
- **kubectl exec -it po/nginx —sh -c c1 [container-1]**
- **kubectl exec -it po/nginx —sh -c c2** **[container-1]**
-