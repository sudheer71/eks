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
    

## commands

## Help

- **kubectl -h**

## Api-resources

- kubectl api-resource

## Run

- **kubectl run -h**  Create and run a particular image in a pod.

## Service

- **kubectl get svc**

## NameSpace

- **kubectl get namespace**

## pod

- **kubectl get pods**
- **kubectl get all** [it will give a list of all the resources list]
- **kubectl get pods,svc, namespace**
- **kubectl get po,svc** —all-namespace All the namespaces
- **kubectl get po,svc** -A [All the namespaces]
- **kubectl get po | grep -i ng** [To get the list of pods nginx]
- **kubectl get po —show-labels**

## **Describe**

- **kubectl describe po nginx**

## **Events**

- **kubectl events** [Prints a table of the most important information about events.]. You can request events for a namespace, for all namespaces, or filter them to only those pertaining to a specified resource.
- **kubectl events -n <namespace-name>**
- kubectl get event | grep -i ErrImagePull

## logs

- **kubectl logs** [Print the logs for a container in a pod or specified resource. If the pod has only one container, the container name is optional]
- **kubectl logs po/nginx [stored logs]**
- **kubectl logs -f po/ngnix [follow-up logs/streamed logs]**
- **kubectl logs -f --timestamps=true po/ngnix**
- **kubectl logs -f —tail=5 --timestamps=true po/ngnix**
- **kubectl logs po/ngnix —all-containers=true**
- **kubectl logs po/nginx -c c1 [container-1]** to get logs from container-1
- **kubectl logs po/nginx -c c2 [container-2]** to get logs from container-2

## exec:

- **kubectl exec -it po/nginx — sh**
- **kubectl exec -it po/nginx — bash**
- **kubectl exec -it po/nginx — hostname**
- **kubectl exec -it po/nginx — curl [localhost](http://localhost)**
- **kubectl exec -it po/nginx —sh -c c1 [container-1]**
- **kubectl exec -it po/nginx —sh -c c2** **[container-1]**

## Edit :

- kubectl edit -h
- kubectl edit po/nginx
- 

## Delete

- kubectl delete po/nginx
- kubectl delete -f test.yaml
- kubectl delete all [it will delete all the resources in the name space ]

## Dry run

- kubectl run nginx --image=nginx:1.19 --dry-run=client -o yaml

## Explain :

 **Describe the fields and structure of various resources**.

This command describes the fields associated with each supported API resource. Fields are identified via a simple JSONPath identifier:

```
    <type>.<fieldName>[.<fieldName>]
kubectl explain pod.spec.container.pots.....[etc]

apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: nginx
  labels:
    run: nginx
    env: qa
    app: test  
spec:
  containers:
  - image: nginx:1.19
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```

- kubectl explain -h
- kubectl explain pods
- kubectl explain pods.spec
- kubectl explain pods.spec.containers
- kubectl explain pods.spec.containers.ports

## show-labels

- kubectl get pods — show-labeles

## Copying files to and from containers

- Sometimes we may want to add a file to a running container or retrieve a file from it during development phases
- Kubectl offers the cp command to copy files or directories from your local computer to a container of any pod or from the container to your computer
    
    ### Copying from pod to local
    
    ```bash
    kubectl cp nginx:/usr/share/nginx/html/index.html -c c2 •/index.html
    ```
    
    ### Copying From local to pod
    
    ```bash
    kubectl cp index.html nginx:/usr/share/nginx/html/index.html -c c1
    ```
    

## Pods Declarative file with **stdin** and **tty** flags

- Declarative file with **stdin** and **tty** flags
    - -i, which makes sure STDIN is kept open. You need this for entering commands into the shell
    - -t, which allocates a pseudo terminal (TTY)
- This is required for some images with **bash** or **sh** as the default CMD

```go
kubectl run os --image=ubuntu -it
```

```yaml
apiVersion: v1
kind: Pod 
metadata:
 name: test 
spec:
 containers:
 - name: test
   image: test
   stdin: true 
   tty: true

```

## Run a temp pod

- You can also fire up an interactive Pod within a Kubernetes cluster that is deleted once you exit the interactive session
- --rm ensures that the pod is deleted when you exit the interactive shell
- i/--tty: The combination of these two are what allows us to attach to an interactive session
- -: Delimits the end of the kubecti run options from the positional arg (bash)
- bash: Overrides the container's CMD. In this case, we want to launch bash as our container's command

```bash
kubectl run test-pod --image=alpine --rm -it 
kubectl run my-shell --rm -it --image ubuntu -- bash
kubectl run tmp-shell --rm -i --tty --image centos -- /bin/bash
```

## Image Pull Policy

- Determines if the container image should be pulled from the repository prior to starting the container
- If the tag is latest, k8s defaults imagePullPolicy to Always
Otherwise, defaults imagePullPolicy to IfNotPresent.
    
    ![image.png](/Users/muthyalasudheer/Documents/wrokPlace/code/eks/kubernetes/vik/images/Screenshot 2025-04-22 at 9.55.45 PM.png)
    

```yaml
apiVersion: vl 
kind: Pod 
metadata:
  name: app
spec:
  containers:
  - name: jira
    image: [myregistry.com/jira:2.0](http://myregistry.com/jira:2.0)
    imagePullPolicy: Always
  imagePullSecrets:
    - name: myregistry.com-registry-credentials
```

-