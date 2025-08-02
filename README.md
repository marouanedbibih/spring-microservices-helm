# Spring Cloud Microservices Helm Chart

## Structure Overview
This Helm chart is structured to deploy a Spring Cloud microservices architecture, including Eureka, Gateway, Car Service, Client Service, Web Frontend, and MySQL. The chart is designed to be flexible and configurable for different environments (development, staging, production) using separate values files.
```bash
spring-cloud-app/
├── Chart.yaml                 # Main umbrella chart
├── values.yaml               # Global configuration
├── values-dev.yaml          # Development overrides
├── values-staging.yaml      # Staging overrides
├── values-prod.yaml         # Production overrides
├── templates/
│   ├── namespace.yaml
│   ├── secrets.yaml         # Global secrets
│   └── ingress.yaml        # Global ingress
└── charts/                  # Subcharts directory
    ├── eureka/
    ├── gateway/
    ├── car-service/
    ├── client-service/
    ├── web-frontend/
    └── mysql/
```