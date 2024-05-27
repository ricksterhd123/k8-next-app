#! /usr/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/../.env
kubectl create namespace $NAMESPACE
kubectl config set-context --current --namespace $NAMESPACE
docker login $REGISTRY_URL --username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD
kubectl create secret docker-registry $REGISTRY_SECRET --docker-server=$REGISTRY_URL --docker-username=$REGISTRY_USERNAME --docker-password=$REGISTRY_PASSWORD
