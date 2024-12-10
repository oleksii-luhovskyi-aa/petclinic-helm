#!/bin/bash

IMAGE_TAG=$(gcloud artifacts docker images list us-central1-docker.pkg.dev/atlantean-yeti-440716-a1/jenkins-docker-repo/petclinic --sort-by=~update_time --include-tags --limit=1 --format="value(tags)")

helm uninstall petclinic-deploy

helm install --set image.tag=${IMAGE_TAG} petclinic-deploy petclinic-simple-chart/