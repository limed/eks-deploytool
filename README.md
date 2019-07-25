# eks-deploy
This is a proof of concept to standardize deployment through a CI system to AWS EKS.
eks-deploy consists of a framework of scripts that helps gitops workflow with docker and AWS EKS

## Basics
If you have an app that you need to setup in k8s you need to create a deploy folder in your app code,

Example of folder layout:
```plaintext
app-code/
├── deploy/
│   ├── meatadata.yaml
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
