{{- define "wuda.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}

{{- define "wuda.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "wuda.selectorLabels" -}}
app.kubernetes.io/name: {{ .ctx.Chart.Name }}
app.kubernetes.io/instance: {{ .ctx.Release.Name }}
app.kubernetes.io/component: {{ .component }}
{{- end }}

{{- define "wuda.image" -}}
{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end }}

{{- define "wuda.dbHost" -}}
{{- if .Values.postgresql.enabled -}}
{{- printf "%s-postgresql" (include "wuda.fullname" .) -}}
{{- else -}}
{{- required "database.host is required when postgresql.enabled=false" .Values.database.host -}}
{{- end -}}
{{- end }}

{{- define "wuda.dbSecretName" -}}
{{- default (printf "%s-db" (include "wuda.fullname" .)) .Values.database.existingSecret -}}
{{- end }}

{{- define "wuda.dbSecretKey" -}}
{{- if .Values.database.existingSecret -}}{{ .Values.database.existingSecretKey }}{{- else -}}password{{- end -}}
{{- end }}

{{- define "wuda.djangoSecretName" -}}
{{- default (printf "%s-django" (include "wuda.fullname" .)) .Values.django.existingSecret -}}
{{- end }}

{{- define "wuda.djangoSecretKey" -}}
{{- if .Values.django.existingSecret -}}{{ .Values.django.existingSecretKey }}{{- else -}}secret-key{{- end -}}
{{- end }}

{{/* Secret-backed environment shared by the app and the migration init container */}}
{{- define "wuda.secretEnv" -}}
- name: DJANGO_SECRET_KEY
  valueFrom:
    secretKeyRef:
      name: {{ include "wuda.djangoSecretName" . }}
      key: {{ include "wuda.djangoSecretKey" . }}
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "wuda.dbSecretName" . }}
      key: {{ include "wuda.dbSecretKey" . }}
{{- with .Values.extraEnv }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{- define "wuda.containerSecurityContext" -}}
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
runAsNonRoot: true
capabilities:
  drop: ["ALL"]
{{- end }}
