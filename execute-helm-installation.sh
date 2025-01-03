#!/bin/bash

SERVICE_NAME=$1

SERVICE_PORT=$2

NEED_RECREATE=$3

IMAGE_TAG=$(gcloud artifacts docker images list us-central1-docker.pkg.dev/atlantean-yeti-440716-a1/jenkins-docker-repo/petclinic --sort-by=~update_time --include-tags --limit=1 --format="value(tags)")

helm uninstall deployment-${SERVICE_NAME}

helm install --set image.tag=${IMAGE_TAG} --set service.name=${SERVICE_NAME} --set service.port=${SERVICE_PORT} --set needRecreate=${NEED_RECREATE} deployment-${SERVICE_NAME} petclinic-simple-chart/