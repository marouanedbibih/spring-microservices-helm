# MySQL Configuration Examples

This Helm chart supports both internal MySQL (deployed as part of the chart) and external MySQL configurations.

## Internal MySQL (Default)

When `mysql.enabled=true` (default), MySQL will be deployed as part of the chart:

```yaml
mysql:
  enabled: true
  auth:
    username: app_user
    password: app_password123
    database: app_db
  service:
    port: 3306
```

The client service will automatically connect to: `{release-name}-mysql.{namespace}.svc.cluster.local:3306`

## External MySQL

When `mysql.enabled=false`, you can configure an external MySQL instance:

```yaml
mysql:
  enabled: false
  external:
    host: "your-external-mysql.example.com"
    port: 3306

clientService:
  secrets:
    database:
      username: "your_external_user"
      password: "your_external_password"
```

## Dynamic Detection

The chart uses Helm helpers to automatically detect the correct MySQL configuration:

- `{{ include "mysql.dns.fqdn" . }}` - Returns the appropriate MySQL host
- `{{ include "mysql.port" . }}` - Returns the appropriate MySQL port
- Credentials are automatically selected based on `mysql.enabled` flag

## DNS Resolution

The chart is configured with proper Kubernetes DNS settings:

```yaml
dnsConfig:
  options:
    - name: ndots
      value: "2"
    - name: single-request-reopen
```

This ensures services can resolve each other using FQDN: `service.namespace.svc.cluster.local`
