{{/*
Expand the name of the chart.
*/}}
{{- define "meteread.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "meteread.fullname" -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "meteread.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
meteread selector labels
*/}}
{{- define "meteread.selectorLabels" -}}
app.kubernetes.io/name: meteread
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
influxdb selector labels
*/}}
{{- define "influxdb.selectorLabels" -}}
app.kubernetes.io/name: influxdb
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
