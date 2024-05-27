#! /usr/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/../.env

kubectl create secret docker-registry $REGISTRY_SECRET --docker-server=$REGISTRY_URL --docker-username=$REGISTRY_USERNAME --docker-password=$REGISTRY_PASSWORD
helm install my-k8-next-app $SCRIPT_DIR/../chart --set image.name=$PROJECT_NAME --set image.uri=$REGISTRY_URL/$PROJECT_NAME --set image.imagePullSecrets=$REGISTRY_SECRET
kubectl rollout restart deployment my-k8-next-app
