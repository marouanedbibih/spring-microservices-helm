# Car Service Helm Manifests Summary

## Generated Files for Car Service

### 1. ConfigMap (`car-configmap.yaml`)
- **Purpose**: Stores non-sensitive configuration
- **Key configurations**:
  - Spring profiles, application name, service port
  - MySQL connection details (automatically resolves to primary MySQL service)
  - JPA/Hibernate settings
  - Logging levels
  - Eureka client configuration with full DNS names

### 2. Secret (`car-secret.yaml`)
- **Purpose**: Stores sensitive data (passwords, credentials)
- **Key secrets**:
  - Database username and password (dynamically chosen based on MySQL deployment)
  - Java options for JVM tuning

### 3. Deployment (`car-deployment.yaml`)
- **Purpose**: Defines the car service pods
- **Key features**:
  - Environment variables mapped from ConfigMap and Secret
  - Health checks (liveness and readiness probes)
  - DNS configuration for service discovery
  - Security context
  - Resource limits and requests

### 4. Service (`car-service.yaml`)
- **Purpose**: Exposes car service internally in the cluster
- **Configuration**: ClusterIP service on port 8802

### 5. Ingress (`car-ingress.yaml`)
- **Purpose**: Exposes car service externally via nginx ingress
- **Configuration**: Routes traffic from `car.marouanedbibih.engineer` to car service

## Environment Variable Mapping

### Your Spring Boot Configuration → Kubernetes Environment Variables

| Spring Boot Property | Environment Variable | Source |
|----------------------|---------------------|---------|
| `server.port` | `CAR_SERVICE_PORT` | ConfigMap |
| `spring.application.name` | `SPRING_APPLICATION_NAME_CAR` | ConfigMap |
| `spring.datasource.url` components | `MYSQL_HOST`, `MYSQL_PORT`, `DATABASE_NAME_CAR` | ConfigMap |
| `spring.datasource.username` | `DATABASE_USERNAME_CAR` | Secret |
| `spring.datasource.password` | `DATABASE_PASSWORD_CAR` | Secret |
| `spring.jpa.hibernate.ddl-auto` | `JPA_HIBERNATE_DDL_AUTO` | ConfigMap |
| `logging.level.org.hibernate.SQL` | `LOGGING_LEVEL_ORG_HIBERNATE_SQL` | ConfigMap |
| `logging.level.org.springframework` | `LOGGING_LEVEL_ORG_SPRINGFRAMEWORK` | ConfigMap |
| `eureka.client.service-url.defaultZone` | `EUREKA_CLIENT_SERVICEURL_DEFAULTZONE` | ConfigMap |

## Values.yaml Configuration

Added `carService` section with:
- Image configuration (repository, tag, pull policy)
- Container port (8802)
- ConfigMap settings (database, logging, JPA, etc.)
- Secret settings (credentials, Java opts)
- Service configuration (ClusterIP, port 8802)
- Ingress configuration (nginx, TLS support)

## Service Discovery

The car service will:
1. **Connect to MySQL**: `spring-mysql-primary.dev.svc.cluster.local:3306`
2. **Register with Eureka**: `spring-eureka-server.dev.svc.cluster.local:8761`
3. **Be accessible internally**: `spring-car-service.dev.svc.cluster.local:8802`
4. **Be accessible externally**: `https://car.marouanedbibih.engineer`

## Deployment Commands

```bash
# Test the template
helm template spring /path/to/helm/ -n dev

# Deploy/upgrade
helm upgrade spring /path/to/helm/ -n dev

# Check car service status
kubectl get pods -n dev | grep car-service
kubectl get svc -n dev | grep car-service
kubectl logs -f deployment/spring-car-service -n dev
```

## Health Checks

- **Liveness Probe**: `/actuator/health` (starts after 120s, checks every 30s)
- **Readiness Probe**: `/actuator/health` (starts after 90s, checks every 10s)

This setup ensures your car service will have the exact same environment variables that your `application-prod.yml` expects, with proper service discovery and configuration management.
