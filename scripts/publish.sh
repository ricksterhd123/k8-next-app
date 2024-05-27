#!/usr/bin/env bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/../.env
docker login $REGISTRY_URL --username $REGISTRY_USERNAME --password $REGISTRY_PASSWORD
docker build -t $PROJECT_NAME:latest $SCRIPT_DIR/..
docker tag $PROJECT_NAME:latest $REGISTRY_URL/$PROJECT_NAME:latest
docker push $REGISTRY_URL/$PROJECT_NAME:latest
