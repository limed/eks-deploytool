# AWS IAM
In order to allow this tool to pull the kubeconfig from AWS you will need to generate an access key pair with the following permission

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole",
                "sts:GetFederationToken"
            ],
            "Resource": "arn:aws:iam::<account id>:user/<iam username>"
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster"
            ],
            "Resource": "*"
        }
    ]
}
```
