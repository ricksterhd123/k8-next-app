#! /usr/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/../.env
helm install my-k8-next-app $SCRIPT_DIR/../chart --set image.name=$PROJECT_NAME --set image.uri=$REGISTRY_URL/$PROJECT_NAME --set image.imagePullSecrets=$REGISTRY_SECRET
kubectl rollout restart deployment my-k8-next-app
