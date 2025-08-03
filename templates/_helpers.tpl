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

{{/* Car service helpers */}}
{{- define "car.name" -}}
car-service
{{- end }}

{{- define "car.fullname" -}}
{{ .Release.Name }}-car-service
{{- end }}

{{/* Gateway service helpers */}}
{{- define "gateway.name" -}}
gateway-service
{{- end }}

{{- define "gateway.fullname" -}}
{{ .Release.Name }}-gateway-service
{{- end }}

{{/* Web application helpers */}}
{{- define "web.name" -}}
web-app
{{- end }}

{{- define "web.fullname" -}}
{{ .Release.Name }}-web-app
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

{{- define "car.configmap.name" -}}
{{ include "car.fullname" . }}-config
{{- end }}

{{- define "car.secret.name" -}}
{{ include "car.fullname" . }}-secrets
{{- end }}

{{- define "gateway.configmap.name" -}}
{{ include "gateway.fullname" . }}-config
{{- end }}

{{- define "gateway.secret.name" -}}
{{ include "gateway.fullname" . }}-secrets
{{- end }}

{{- define "web.configmap.name" -}}
{{ include "web.fullname" . }}-config
{{- end }}

{{- define "web.secret.name" -}}
{{ include "web.fullname" . }}-secrets
{{- end }}