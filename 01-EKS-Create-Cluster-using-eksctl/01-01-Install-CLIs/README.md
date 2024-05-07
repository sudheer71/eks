# Install AWS, kubectl & eksctl CLI's

## Introduction
- Install AWS CLI [Linux](https://github.com/sudheermuthyala/EKS/tree/main/01-EKS-Create-Cluster-using-eksctl/01-01-Install-CLIs#linux---install-and-configure-aws-cli)
- Install kubectl CLI [Linux](https://github.com/sudheermuthyala/EKS/tree/main/01-EKS-Create-Cluster-using-eksctl/01-01-Install-CLIs#install-kubectl-cli)
- Install eksctl CLI [Linux](https://github.com/sudheermuthyala/EKS/tree/main/01-EKS-Create-Cluster-using-eksctl/01-01-Install-CLIs#install-eksctl-cli-on-linux)

## Linux - Install and configure AWS CLI 
- Download the binary and install via command line using below two commands.
- [Reference](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
```t
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
- Verify the installation

```t
aws --version
aws-cli/2.10.3 Python/3.9.11 Linux/4.18.0-257.el8.x86_64 exe/x86_64.centos.8 prompt/off

which aws



```

- update your current installation of the AWS CLI
```t
sudo ./aws/install --update

```

## Configure AWS Command Line using Security Credentials
- Go to AWS Management Console --> Services --> IAM
- Select the IAM User: kalyan 
- **Important Note:** Use only IAM user to generate **Security Credentials**. Never ever use Root User. (Highly not recommended)
- Click on **Security credentials** tab
- Click on **Create access key**
- Copy Access ID and Secret access key
- Go to command line and provide the required details
```
aws configure
AWS Access Key ID [None]: ABCDEFGHIAZBERTUCNGG  (Replace your creds when prompted)
AWS Secret Access Key [None]: uMe7fumK1IdDB094q2sGFhM5Bqt3HQRw3IHZzBDTm  (Replace your creds when prompted)
Default region name [None]: us-east-1
Default output format [None]: json
```
- Test if AWS CLI is working after configuring the above
```
aws ec2 describe-vpcs
```

## Install kubectl CLI 
- **IMPORTANT NOTE:** Kubectl binaries for EKS please prefer to use from Amazon (**Amazon EKS-vended kubectl binary**)
- This will help us to get the exact Kubectl client version based on our EKS Cluster version. You can use the below documentation link to download the binary.
- Reference: https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

```t
## Download the kubectl binary 
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.25.6/2023-01-30/bin/linux/amd64/kubectl

# Provide execute permissions
chmod +x ./kubectl

# Set the Path by copying to user Home Directory
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc 

# Verify the kubectl version
kubectl version --short --client
kubectl version  --client

# Output: 
Client Version: v1.25.6-eks-48e63af
Kustomize Version: v4.5.7
```
##  Install eksctl CLI On Linux
- For windows and linux OS, you can refer below documentation link.
- Reference: https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html#installing-eksctl

```t
# Download and extract the latest release of eksctl with the following command.
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
# Move the extracted binary to /usr/local/bin.
sudo mv /tmp/eksctl /usr/local/bin
# Test that your installation was successful with the following command.
eksctl version

```

## Getting started with Amazon EKS – eksctl
References:
- https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html