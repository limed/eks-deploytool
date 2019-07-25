# Travis CI RBAC
Generally you shouldn't grant your CI system full admin access to your K8S cluster, so what you should do here
is create a Role in your cluster that only grants access to a specific namespace

Below is a sample RBAC policy that creates a group to only allow access to a specific namespace, in this case
its the namespace `stage`
```plaintext
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: stage-full-access
  namespace: stage
rules:
- apiGroups: [""]
  resources:
    - namespaces
  verbs:
    - get
    - list
    - watch
- apiGroups: ["", "extensions", "apps"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources:
  - jobs
  - cronjobs
  verbs: ["*"]

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: stage-access
  namespace: stage
subjects:
- kind: Group
  name: "travis-access"
  namespace: stage
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: stage-full-access
```
