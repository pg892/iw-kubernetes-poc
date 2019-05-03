# DotNet core WebApp using docker and kubernetes

This is a sample dotnet core 2.1 ASP NET MVC web app. 
This app is configured to run in Docker container (Dockerfile).
The goal of this POC is to explain how to run and manage this container locally on Windows 10 machine
using the container orchestration service Kubernetes. 
One of the services that can do that is Minikube.

## Prerequisites
We need to create the image and container before we begin.
We will create image with this command:

```
docker build -t kube-poc:1 .
```

and container:

```
docker run -it --name kube-poc 5005:80 kube-poc:1
```

The container will run locally on port 5005

## Getting started
Kubernetes is container orchestration service that runs on Linux and can easily manage multiple containers.
One Kubernetes cluster contains two main components:
    * Masters - in charge, control plane (monitors, makes changes, schedules work, response to events etc)
    * Nodes - do the actual work

### Masters
The master component is made by 4 elements:
    * Kube-apiserver - Front End to the control plane (Exposes Restful API, Consumes Json)
    * Cluster Store - Persistent Storage (etcd Key-Value store)
    * Kube-controller-manager - It is controller of controllers (watches for changes - if current state matches desired state)
    * Kube-Scheduler - Watches apiserver for new pods (assigns work to nodes)

### Nodes
The nodes component is made by 3 elements:
    * Kubelet - Main Kubernetes agent (register node with cluster, watches api server, instantiates pods, reports to master)
    * Container Engine - Container managment (Docker or Core OS rkt)
    * Kube-proxy - For networking (every pod has one IP, all containers in POD share single IP, load balances across pods in service)

### Pods
Pod is automic unit of scheduling in the Kubernetes world. All containers run inside of the pod and one or more pod live inside of the node. Pod is ring-fenced environment and it has network stack, kernel namespace etc.

### Services and deployments
The main thing that services does is load balance the actual work in the nodes accross multiple pods.
With the deployments we can specify the manifest file with the actual replicas and config for the whole
kubernetes cluster in order to deploy the cluster.

## Minikube (local machine setup)
Minikube is a tool that makes it easy to run Kubernetes locally. It creates a local VM on the HOST.
It creates single node kubernetes cluster. For more info about minikube go to: [Minukube](https://kubernetes.io/docs/setup/minikube/#minikube-features)

### Minikube installation
Go and install 64 bit version of minikube from this location: [MinikubeRepo](https://github.com/kubernetes/minikube/releases)

### Kubernetes client installation
From our local machine we can install client to access kubernetes that runs on the VM. That client is Kubectl.
This is the installation location: [Kubectl](https://storage.googleapis.com/kubernetes-release/release/v1.11.0/bin/windows/amd64/kubectl.exe)

### Minikube setup
VT-x or AMD-v virtualization must be enabled in your computer’s BIOS.
As a VM I am using Hyper-V. Before everything the new external virtual switch should be created for Hyper-V.
After all of these command should be run:

```
minikube start --kubernetes-version="<kubernetes-version>" --vm-driver="hyperv" --hyperv-virtual-switch="<name-of-virtual-switch"
```

After this single node cluster is set and it is up we can see all nodes with this command:

```
kubectl nodes
```

Also we can see the dasboard with the command:

```
minikube dashboard
```

## Azure AKS 
Azure Kubernetes Service is a fully managed service by Azure that manages the masters control pane and node configuration.
Also Azure has its own private container registry (ACR) where the container images can be pushed directly. 

## Azure Setup
For the full working azure setup refer to this [blog](https://msdn.microsoft.com/en-us/magazine/mt830375)

## Authors
* **Petar Gjeorgiev**