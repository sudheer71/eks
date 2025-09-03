
#cre () { 

eksctl create cluster --name=mseks \
                      --region=us-east-1 \
                      --zones=us-east-1a,us-east-1b \
                      --without-nodegroup 


eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster mseks \
    --approve 


eksctl create nodegroup --cluster=mseks \
                       --region=us-east-1 \
                       --name=mseks-ng-public1 \
                       --node-type=t3.medium \
                       --nodes=2 \
                       --nodes-min=2 \
                       --nodes-max=4 \
                       --node-volume-size=20 \
                       --ssh-access \
                       --ssh-public-key=k8s \
                       --managed \
                       --asg-access \
                       --external-dns-access \
                       --full-ecr-access \
                       --appmesh-access \
                       --alb-ingress-access 

#}


#del () {
#eksctl delete cluster --name mseks

#}test

$1 
test
