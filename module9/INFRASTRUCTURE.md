# AWS Project Setup

## DOC1: Setup Code Artifacts

__step1:__ Follow the process to setup code artifactory https://docs.aws.amazon.com/codeartifact/latest/ug/get-set-up-for-codeartifact.html

__step2:__ open https://console.aws.amazon.com/codesuite/codeartifact/repositories

__step3:__ click on `Create repository` button and create a repository with name `book-manager-repository`

## DOC2: Setup AWS Elastic Container Registry

__step1:__ open https://console.aws.amazon.com/ecr/repositories

__step2:__ click on `Create repository` button and create a repository with name `book-manager`

## DOC3 Setup AWS Elastic Kubernetes Service

### Pre requisite

Follow the below documentation to create EKS Cluster Role and Node IAM Role
https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html#create-service-role
https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html


### DOC3.1 Create Cluster

__step1:__ open https://console.aws.amazon.com/eks/home

__step2:__ click on `Add cluster` button and choose `create` option

__step3:__ Provide a name for the cluster say `bookmanager-cluster` and choose the Cluster Service Role created earlier as per steps in the Pre requisite. Click on `Next` button

__step4:__ Choose the `VPC`, `Subnets` and choose Cluster endpoint access as `Public`. Click on `Next` Button

__step5:__ In `Configure logging`, `Select add-ons`, `Configure selected add-ons settings` screens
 keep the options untounched. Click on `Next` Button

__step6:__ In `Review and create` screen. Click on `create` Button to create the cluster.

__Note:__ Cluster creation takes several minutes.

#### DOC3.2 Create EC2 Launch Template 

__step1:__ open https://console.aws.amazon.com/ec2/home and click `Create Launch Template`

__step2:__ 
- check https://docs.aws.amazon.com/eks/latest/userguide/retrieve-ami-id.html to get the AMI ID for `Amazon EKS optimized Amazon Linux Image` and choose the AMI from the list. 
- Select `t3.micro` as Instance type.
- Choose `Key pair` from the list with which you can login into nodes(ec2 instance)
- In the `Network Settings` section choose the security groups
- Open `Advaced details` tab and scroll to last and update `User data` as below
```
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${ClusterName}
```

__Note:__ Update the Cluster Name. In this example `bookmanager-cluster`

```
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh bookmanager-cluster
```
__step3:__ click on `Create Launch Template`

#### DOC3.3 Create Node Group 

__step1:__ open https://console.aws.amazon.com/eks/home

__step2:__ choose the cluster created. Click `bookmanager-cluster`

__step3:__ click on `compute` tab which is third menu after Overview and Resources

__step3:__ click `Add node group` button. 
- Provide the name for the node group
- Choose the `Node IAM Group` created as part of steps provided in Pre requisite section
- Toggle `Use launch template` under `Launch template` section and choose the launch template created.
- Click on `Next` button
- Under `Node group scaling configuration` section, enter Desired size, Minimum size and Maximum size as 2
- Click on `Next` button
- Under `Node group network configuration` choose the subnets and click `Next` button 
- Click `create` button in the `Review and create` screen

Once node group is created, ec2 instances are created and added to Nodes

### DOC4 Create Access Key 

Check following link, create access keys
https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey

check following link how to configure aws cli
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html