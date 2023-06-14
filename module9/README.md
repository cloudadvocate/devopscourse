# Book Manager Application CI CD

## Project Setup

### Fork Project

- open https://github.com/cloudadvocate/devopscourse
- click on Fork button at top right 
- uncheck the option `Copy the main branch only`
- click on `Create Fork` button

### Branch Setup

choose the branch `feature/eks-deploy`

### Repo Setup

- Clone the repository `https://github.com/xxxxxx/devopscourse`
- open `pom.xml` under `module3/book-manager-app` and update project.profiles.profile.repositories.repository url from `https://cloudadvocate-xxxxxxxx.d.codeartifact.ap-south-1.amazonaws.com/maven/book-manager-repository/` to artifactory created as per `DOC1`[here](INFRASTRUCTURE.md)
- open `deployment.yaml` under `module9/bookmanager-deployment` and update docker image `spec.template.spec.containers[0].image` as `XXXXXXXX.dkr.ecr.ap-south-1.amazonaws.com/bookmanager:latest` as per `DOC2`[here](INFRASTRUCTURE.md)

 
### Setup Github Actions

- Open the forked repository https://github.com/xxxxxx/devopscourse 
- Select `Settings` tab, click `Secrets and variables` and choose `Actions`
- click `New repository secret` and add following variables
    - Name: `AWS_ACCESS_KEY` and type-in access key generated from `DOC4` [here](INFRASTRUCTURE.md)
    - Name: `AWS_SECRET_KEY` and type-in secret key generated from `DOC4` [here](INFRASTRUCTURE.md)
- Open `.github/workflows/bookmanager_cicd.yaml` and  
    - Update`env.CLUSTER_NAME` to cluster name as per `DOC3.1` [here](INFRASTRUCTURE.md)
    - Update docker registry id `jobs.build-docker.steps['Build and push'].with.tags` to eks container  registry as per `DOC2` [here](INFRASTRUCTURE.md)
- Open `.github/workflows/bookmanager_eks_deploy.yaml` and update `env.CLUSTER_NAME` to cluster name as per `DOC3.1` [here](INFRASTRUCTURE.md)

### Github Actions Flow

___One time Setup__
- Open the forked reporistory https://github.com/xxxxxx/devopscourse 
- Trigger the workflow `.github/workflows/bookmanager_eks_deploy.yaml`. Please check the following documentation to trigger the workflow manually
https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow#running-a-workflow

__CI CD__
- Make changes to Book Manager Java Application under `module3/book-manager-app`
- Github Action workflow `.github/workflows/bookmanager_cicd.yaml` would perform following steps
    - clone the repository
    - execute junit test cases
    - check code coverage
    - build, package and deploy the code to `Code Artifact`
    - Containerize the artifact and pushed to `AWS Container Registry`
    - Update the EKS Deployment 

















