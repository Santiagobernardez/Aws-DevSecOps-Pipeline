FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
# Security patch: Update OS packages to fix vulnerabilities like CVE-2026-25646
RUN apk update && apk upgrade --no-cache