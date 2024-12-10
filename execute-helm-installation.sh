#!/bin/bash

IMAGE_TAG=$(gcloud artifacts docker images list us-central1-docker.pkg.dev/atlantean-yeti-440716-a1/jenkins-docker-repo --filter="package=us-central1-docker.pkg.dev/atlantean-yeti-440716-a1/jenkins-docker-repo/petclinic" --sort-by="~UPDATE_TIME" --limit=1 --format="value(format("{0}",version))")

sh "helm uninstall petclinic-deploy"

sh "helm install --set image.tag=${IMAGE_TAG} petclinic-deploy petclinic-simple-chart/"