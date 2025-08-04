FROM prom/prometheus:v3.5.0
COPY config/prometheus.yml /etc/prometheus/prometheus.yml
