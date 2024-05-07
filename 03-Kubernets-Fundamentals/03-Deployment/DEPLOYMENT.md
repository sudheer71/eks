# Deployment 
```
kubectl create deployment my-first-deployment --image=stacksimplify/kubenginx:1.0.0
kubectl get deploment
kubectl get deploy
kubectl get replicasets
kubectl get rs
kubectl get pods
kubectl get po
kubectl expose deployment my-first-deployment --type=NodePort --port=80 --target-port=80 --name=my-first-deployment-np-service
kubectl scale deployment --replicas=20 my-first-deployment 
kubectl get svc
kubectl get deployment <deployment-name> -o yaml
kubectl set image deployment <deployment-name> <container-name>=<container-image>=record=true
kubectl rollout history deployment
kubectl rollout history deployments <deployment-name> --revision=<Number>
kubectl rollout undo deployments <deployment-name> --to-revision=<Number>
kubectl describe replicaset <replicaset-namen>
kubectl edit deployment <deployment-name> --record=true
kubectl rollout status deployment <my-frist-deployment>
kubectl rollout history deployments <deployment-Name>
kubectl rollout undo deployment <deployment-name>
kubectl rollout undo deployment <deploymemt-name> --to-revision=<number>
kubectl rollout restart deployment <deploy-name>
kubectl rollout pause deployment <deployment-name>
kubectl set image deployment <deploy-name> <container-name>=<image-name> --record=true
kubectl set resources deployment <deploy-name> -c <container-name> --limits=cpu=20m,memory=30Mi
kubectl rollout resume deployment <deploy-name>
```