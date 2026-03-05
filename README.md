# helm

Helm charts for deploying meteread to Kubernetes.

## Charts

### meteread

Deploys the full meteread stack: the meteread app and InfluxDB 3.

| Component | Kind | Notes |
|-----------|------|-------|
| meteread | Deployment | Privileged; requires host serial device |
| influxdb | StatefulSet | InfluxDB 3-core, no auth |
| influxdb | Service | ClusterIP on port 8181 |
| influxdb-data | PVC | InfluxDB data volume |
| influxdb-plugins | PVC | InfluxDB plugins volume |

#### Prerequisites

- Helm 3
- A node with a DSMR v5 smart meter connected via serial (default `/dev/ttyUSB0`)

#### Install from local chart

```bash
helm install meteread helm/meteread/
```

#### Install from Helm repo

```bash
helm repo add meteread-lib https://meteread-lib.github.io/meteread
helm repo update
helm install meteread meteread-lib/meteread
```

#### Install from OCI registry

```bash
echo $GITHUB_TOKEN | helm registry login ghcr.io -u <username> --password-stdin
helm install meteread oci://ghcr.io/meteread-lib/meteread --version 0.1.0
```

#### Upgrade

```bash
helm upgrade meteread helm/meteread/
# or from repo:
helm upgrade meteread meteread-lib/meteread
# or from OCI:
helm upgrade meteread oci://ghcr.io/meteread-lib/meteread --version 0.1.0
```

#### Uninstall

```bash
helm uninstall meteread
```

Note: PVCs are not deleted on uninstall. Remove them manually if needed:

```bash
kubectl delete pvc meteread-influxdb-data meteread-influxdb-plugins
```

#### Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `meteread.image` | `ghcr.io/meteread-lib/meteread` | meteread image |
| `meteread.tag` | `main` | Image tag |
| `meteread.command` | `["read", "electricity_and_gas"]` | Meter command |
| `meteread.serialDevice` | `/dev/ttyUSB0` | Host serial device path |
| `influxdb.image` | `influxdb` | InfluxDB image |
| `influxdb.tag` | `3-core` | InfluxDB tag |
| `influxdb.dataStorage` | `10Gi` | Data PVC size |
| `influxdb.pluginsStorage` | `1Gi` | Plugins PVC size |
| `influxdb.service.port` | `8181` | InfluxDB service port |

Example — change serial device and meter command:

```bash
helm install meteread helm/meteread/ \
  --set meteread.serialDevice=/dev/ttyUSB1 \
  --set meteread.command='{read,electricity_and_gas}'
```
