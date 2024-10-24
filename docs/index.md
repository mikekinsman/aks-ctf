# AKS CTF

Welcome to the Attacking and Defending Azure Kubernetes Service Clusters.  This is inspired by [Secure Kubernetes](https://securekubernetes.com/), as [presented at KubeCon NA 2019](https://www.youtube.com/watch?v=UdMFTdeAL1s). We'll help you create your own AKS so you can follow along as we take on the role of two attacking personas looking to make some money and one defending persona working hard to keep the cluster safe and healthy.

## Getting Started

Click on [Getting Started](azure/) in the table of contents and follow the directions.

When a `kubectl get pods --all-namespaces` gives output like the following, you're ready to begin the tutorial.

```
$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                         READY   STATUS    RESTARTS   AGE
dev           app-6ffb94966d-9nqnk                         1/1     Running   0          70s
dev           dashboard-5889b89d4-dj7kq                    2/2     Running   0          70s
dev           db-649646fdfc-kzp6g                          1/1     Running   0          70s
...
prd           app-6ffb94966d-nfhn7                         1/1     Running   0          70s
prd           dashboard-7b5fbbc459-sm2zk                   2/2     Running   0          70s
prd           db-649646fdfc-vdwj6                          1/1     Running   0          70s

```


## About the Creators

* [@lastcoolnameleft](https://lastcoolnameleft.com) is a Partner Solution Architect at Microsoft and has supported the Azure partner ecosystem enable and secure their Docker and Kubernetes deployments since joining Microsoft in 2007.
* [@erleonard](https://www.linkedin.com/in/erleonard/) is a Partner Solution Architect at Microsoft focusing on Cloud-Native technologies.
* [@markjgardner](https://markjgardner.com) is a Principal Technical Specialist at Microsoft helping customers to adapt and modernize their business as they move to the cloud. When not working on containerizing all the things, Mark and his wife own and operate a 160 acre horse farm in Kentucky.
* [@swgriffith](https://www.stevegriffith.nyc/) is a Principal Technical Specialist on the Azure App Innovation Global Blackbelt team, where he helps customers build and secure cool things with Azure and Kubernetes. Steve loves securing container ecosystems and helping to educate others on complex and challenging issues. 

This workshop was inspired by https://github.com/securekubernetes/securekubernetes/ and the content created by [those authors](https://github.com/securekubernetes/securekubernetes/?tab=readme-ov-file#about-the-authors).