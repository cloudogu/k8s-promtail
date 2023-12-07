# k8s-promtail betreiben

## Installation

`k8s-promtail` kann als Komponente über den Komponenten-Operator des CES installiert werden.
Dazu muss eine entsprechende Custom-Resource (CR) für die Komponente erstellt werden.

```yaml
apiVersion: k8s.cloudogu.com/v1
kind: Component
metadata:
  name: k8s-promtail
  labels:
    app: ces
spec:
  name: k8s-promtail
  namespace: k8s
  version: 2.9.1-1
```

Die neue yaml-Datei kann anschließend im Kubernetes-Cluster erstellt werden:

```shell
kubectl apply -f k8s-promtail.yaml --namespace ecosystem
```

Der Komponenten-Operator erstellt nun die `k8s-promtail`-Komponente im `ecosystem`-Namespace.

## Upgrade

Zum Upgrade muss die gewünschte Version in der Custom-Resource angegeben werden.
Dazu wird die erstellte CR yaml-Datei editiert und die gewünschte Version eingetragen.
Anschließend die editierte yaml Datei erneut auf den Cluster anwenden:

```shell
kubectl apply -f k8s-promtail.yaml --namespace ecosystem
```

## Konfiguration

Die Komponente kann über das Feld `spec.valuesYamlOverwrite`. Die Konfigurationsmöglichkeiten entsprechen denen von
[Grafana Promtail](https://artifacthub.io/packages/helm/grafana/promtail).
Die Konfiguration für das "Grafana Promtail" Helm-Chart muss in der `values.yaml` unter dem Key `promtail` abgelegt werden.

**Beispiel:**
```yaml
apiVersion: k8s.cloudogu.com/v1
kind: Component
metadata:
  name: k8s-promtail
  labels:
    app: ces
spec:
  name: k8s-promtail
  namespace: k8s
  version: 2.9.1-1
  valuesYamlOverwrite: |
    promtail:
      image:
        pullPolicy: Always
```