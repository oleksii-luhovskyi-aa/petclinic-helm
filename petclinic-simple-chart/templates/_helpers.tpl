{{/*
Expand the name of the chart.
*/}}
{{- define "petclinic-simple-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "petclinic-simple-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "petclinic-simple-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "petclinic-simple-chart.labels" -}}
helm.sh/chart: {{ include "petclinic-simple-chart.chart" . }}
{{ include "petclinic-simple-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "petclinic-simple-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "petclinic-simple-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: petclinic
istio: ingressgateway
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "petclinic-simple-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "petclinic-simple-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the Config Map to use
*/}}
{{- define "petclinic-simple-chart.configname" -}}
{{- printf "%s" .Values.configMap.name }}
{{- end }}

{{/*
Create the name of the Cluster role to use
*/}}
{{- define "petclinic-simple-chart.clusterrolename" -}}
{{- printf "%s" .Values.clusterRole.name }}
{{- end }}