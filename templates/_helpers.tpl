{{- define "spring-cloud-app.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "spring-cloud-app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "spring-cloud-app.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{/* Eureka specific helpers */}}
{{- define "eureka.name" -}}
eureka-server
{{- end }}

{{- define "eureka.fullname" -}}
{{ .Release.Name }}-eureka-server
{{- end }}

{{- define "eureka.servicename" -}}
{{ include "eureka.fullname" . }}
{{- end }}

{{- define "eureka.dns.fqdn" -}}
{{ include "eureka.servicename" . }}.{{ .Release.Namespace }}.svc.cluster.local
{{- end }}

{{/* Client service helpers */}}
{{- define "client.name" -}}
client-service
{{- end }}

{{- define "client.fullname" -}}
{{ .Release.Name }}-client-service
{{- end }}

{{/* MySQL helpers */}}
{{- define "mysql.name" -}}
mysql
{{- end }}

{{- define "mysql.fullname" -}}
{{- if .Values.mysql.enabled -}}
{{ .Release.Name }}-mysql-primary
{{- else -}}
{{ .Values.mysql.external.host }}
{{- end }}
{{- end }}

{{- define "mysql.servicename" -}}
{{- if .Values.mysql.enabled -}}
{{ include "mysql.fullname" . }}
{{- else -}}
{{ .Values.mysql.external.host }}
{{- end }}
{{- end }}

{{- define "mysql.dns.fqdn" -}}
{{- if .Values.mysql.enabled -}}
{{ include "mysql.servicename" . }}.{{ .Release.Namespace }}.svc.cluster.local
{{- else -}}
{{ .Values.mysql.external.host }}
{{- end }}
{{- end }}

{{- define "mysql.port" -}}
{{- if .Values.mysql.enabled -}}
{{ .Values.mysql.service.port | default "3306" }}
{{- else -}}
{{ .Values.mysql.external.port | default "3306" }}
{{- end }}
{{- end }}

{{/* ConfigMap and Secret helpers */}}
{{- define "eureka.configmap.name" -}}
{{ include "eureka.fullname" . }}-config
{{- end }}

{{- define "eureka.secret.name" -}}
{{ include "eureka.fullname" . }}-secrets
{{- end }}

{{- define "client.configmap.name" -}}
{{ include "client.fullname" . }}-config
{{- end }}

{{- define "client.secret.name" -}}
{{ include "client.fullname" . }}-secrets
{{- end }}