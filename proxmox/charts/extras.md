https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/pihole.md
```bash 
kubectl create secret generic pihole-password \
--from-literal EXTERNAL_DNS_PIHOLE_PASSWORD=supersecret
```
```yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: external-dns
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: external-dns
rules:
- apiGroups: [""]
  resources: ["services","endpoints","pods"]
  verbs: ["get","watch","list"]
- apiGroups: ["extensions","networking.k8s.io"]
  resources: ["ingresses"]
  verbs: ["get","watch","list"]
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["list","watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: external-dns-viewer
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: external-dns
subjects:
- kind: ServiceAccount
  name: external-dns
  namespace: default
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: external-dns
spec:
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: external-dns
  template:
    metadata:
      labels:
        app: external-dns
    spec:
      serviceAccountName: external-dns
      containers:
      - name: external-dns
        image: registry.k8s.io/external-dns/external-dns:v0.15.0
        # If authentication is disabled and/or you didn't create
        # a secret, you can remove this block.
        envFrom:
        - secretRef:
            # Change this if you gave the secret a different name
            name: pihole-password
        args:
        - --source=service
        - --source=ingress
        # Pihole only supports A/AAAA/CNAME records so there is no mechanism to track ownership.
        # You don't need to set this flag, but if you leave it unset, you will receive warning
        # logs when ExternalDNS attempts to create TXT records.
        - --registry=noop
        # IMPORTANT: If you have records that you manage manually in Pi-hole, set
        # the policy to upsert-only so they do not get deleted.
        - --policy=upsert-only
        - --provider=pihole
        # Change this to the actual address of your Pi-hole web server
        - --pihole-server=http://ts-ts-egress-pihole-mhg4w.tailscale.svc.cluster.local
      securityContext:
        fsGroup: 65534 # For ExternalDNS to be able to read Kubernetes token files
```

```yaml
        apiVersion: v1
        kind: Service
        metadata:
          annotations:
            tailscale.com/tailnet-fqdn: pihole-proxmox
          name: ts-egress-pihole
        spec:
          externalName: placeholder 
          type: ExternalName
```