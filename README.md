# eks-deploy
This is a proof of concept to standardize deployment through a CI system to AWS EKS.
`eks-deploy` consists of a framework of scripts that helps gitops workflow with docker and AWS EKS

## Basics
If you have an app that you need to setup in k8s you need to create a deploy folder in your app code,

Example of folder layout:
```plaintext
app-code/
├── deploy/
│   ├── metadata.yaml
│   ├── stage.yaml
│   ├── prod.yaml
│   ├── stage/
│   │   ├── env.sh
│   │   ├── k8s_manifest1.yaml
│   │   └── k8s_manifest2.yaml
│   └── prod/
│       ├── env.sh
│       ├── k8s_manifest1.yaml
│       └── k8s_manifest2.yaml
├── app.py
├── Dockerfile
└── .travis.yml
```

Your `metadata.yaml` describes the project and most importantly the environments that your app will need.

Example of `metadata.yaml`
```
---
project_name: your_project_name_here
account_name: your_aws_account_name

environments:
  - stage
  - prod
```

With the `environments` described, and using the `metadata.yaml` file above as an example you will then need
to create a `stage` and `prod` folder and a `stage.yaml` and `prod.yaml` file. The `stage` and `prod` folders
should contain your `k8s` manifests (deployment, service, etc).

The environment yaml file should contain information about the cluster to deploy to, the namespaces and the name
of the k8s manifest file.

```plaintext
---
k8s_cluster: eks-cluster-name
aws_region: us-west-2

namespace: stage

# deployment file list
deployments:
  - app.deployment.yaml
```
