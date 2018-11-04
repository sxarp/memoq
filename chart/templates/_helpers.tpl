{{/*
Expand the name of the chart.
*/}}
{{- define "backend.name" -}}
{{- .Values.name -}}
{{- end -}}

{{- define "backend-proxy.name" -}}
{{- .Values.name -}}-proxy
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
