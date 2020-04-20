{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "puppetserver.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf .Release.Name | trunc 34 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 34 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 52 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "puppetserver.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 52 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf .Release.Name | trunc 52 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 52 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create the args array for "r10k_code_cronjob.sh"
*/}}
{{- define "r10k.code.args" -}}
{{- join " " .Values.r10k.code.extraArgs }}
{{- end -}}

{{/*
Create the args array for "r10k_hiera_cronjob.sh"
*/}}
{{- define "r10k.hiera.args" -}}
{{- join " " .Values.r10k.hiera.extraArgs }}
{{- end -}}

{{/*
Create unified labels for Puppetserver components
*/}}
{{- define "puppetserver.common.matchLabels" -}}
app: {{ template "puppetserver.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{- define "puppetserver.common.metaLabels" -}}
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
heritage: {{ .Release.Service }}
{{- end -}}

{{- define "puppetserver.puppet.labels" -}}
{{ include "puppetserver.common.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.hiera.labels" -}}
{{ include "puppetserver.hiera.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.hiera.matchLabels" -}}
component: {{ .Values.hiera.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.r10k.labels" -}}
{{ include "puppetserver.r10k.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.r10k.matchLabels" -}}
component: {{ .Values.r10k.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.postgres.labels" -}}
{{ include "puppetserver.postgres.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.postgres.matchLabels" -}}
component: {{ .Values.postgres.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetdb.labels" -}}
{{ include "puppetserver.puppetdb.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetdb.matchLabels" -}}
component: {{ .Values.puppetdb.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetboard.labels" -}}
{{ include "puppetserver.puppetboard.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetboard.matchLabels" -}}
component: {{ .Values.puppetboard.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver.labels" -}}
{{ include "puppetserver.puppetserver.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver.matchLabels" -}}
component: {{ .Values.puppetserver.name | quote }}
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-data.labels" -}}
{{ include "puppetserver.puppetserver-data.matchLabels" . }}
{{ include "puppetserver.common.metaLabels" . }}
{{- end -}}

{{- define "puppetserver.puppetserver-data.matchLabels" -}}
component: "{{ .Values.puppetserver.name}}-serverdata"
{{ include "puppetserver.common.matchLabels" . }}
{{- end -}}

{{/*
Set mandatory Puppet Server Service name.
*/}}
{{- define "puppetserver.puppetserver.serviceName" -}}
puppet
{{- end -}}

{{/*
Create the name for the PuppetDB password secret.
*/}}
{{- define "puppetdb.secret" -}}
{{- if .Values.puppetdb.credentials.existingSecret -}}
  {{- .Values.puppetdb.credentials.existingSecret -}}
{{- else -}}
  puppetdb-secret
{{- end -}}
{{- end -}}

{{/*
Create the name for the PuppetDB password secret key.
*/}}
{{- define "puppetdb.passwordKey" -}}
{{- if .Values.puppetdb.credentials.existingSecretKey -}}
  {{- .Values.puppetdb.credentials.existingSecretKey -}}
{{- else -}}
  password
{{- end -}}
{{- end -}}

{{/*
Create the name for the PostgreSQL password secret.
*/}}
{{- define "postgres.secret" -}}
{{- if .Values.postgres.credentials.existingSecret -}}
  {{- .Values.postgres.credentials.existingSecret -}}
{{- else -}}
  postgres-secret
{{- end -}}
{{- end -}}

{{/*
Create the name for the PostgreSQL password secret key.
*/}}
{{- define "postgres.passwordKey" -}}
{{- if .Values.postgres.credentials.existingSecretKey -}}
  {{- .Values.postgres.credentials.existingSecretKey -}}
{{- else -}}
  password
{{- end -}}
{{- end -}}

{{/*
Create the name for the r10k.code secret.
*/}}
{{- define "r10k.code.secret" -}}
{{- if .Values.r10k.code.viaSsh.credentials.existingSecret -}}
  {{- .Values.r10k.code.viaSsh.credentials.existingSecret -}}
{{- else -}}
  r10k-code-creds
{{- end -}}
{{- end -}}

{{/*
Create the name for the r10k.hiera secret.
*/}}
{{- define "r10k.hiera.secret" -}}
{{- if .Values.r10k.hiera.viaSsh.credentials.existingSecret -}}
  {{- .Values.r10k.hiera.viaSsh.credentials.existingSecret -}}
{{- else -}}
  r10k-hiera-creds
{{- end -}}
{{- end -}}

{{/* *************************************************************************************
The following definitions were more complex and necessary during part of this development.
Now they are essentially just stubs but left here in case they might be needed again soon.
************************************************************************************* */}}

{{/*
Create the name for the hiera eyaml key configMap (private/public keys combined).
*/}}
{{- define "puppetserver.hiera.existingMap" -}}
{{- if .Values.hiera.eyaml.existingMap -}}
  {{- .Values.hiera.eyaml.existingMap -}}
{{- end -}}
{{- end -}}

{{/*
Create the name for the hiera eyaml private key configMap.
*/}}
{{- define "puppetserver.hiera.privateMap" -}}
  eyamlpriv-config
{{- end -}}

{{/*
Create the name for the hiera eyaml public cert configMap.
*/}}
{{- define "puppetserver.hiera.publicMap" -}}
  eyamlpub-config
{{- end -}}
