# Docker - Multi Stage Build

A multistage Docker build process makes it possible to build out an application and then remove any unnecessary development tools from the container. This approach reduces the container's final size.

## About Multistage Build

A multistage Docker build is a process to create a Docker image through a series of steps. 
Each stage accomplishes a task, such as 
1. Install development environment dependencies, 
2. Build code
3. Deploy/Run application in lightweight environment

## Build Application 

```
docker build . -t calculator:latest
```

## Run Application

```
docker run -d -p 8080:80 calculator:latest
```

## Deploy to AWS ECR


### Create Repository

Login in to console and create repository named `calculator`
https://<region>.console.aws.amazon.com/ecr/repositories?region=<region>
example:
https://ap-south-1.console.aws.amazon.com/ecr/repositories?region=ap-south-1


### Retrieve an authentication token and authenticate your Docker client to your registry.

```
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_number>.dkr.ecr.<region>.amazonaws.com
```

### Tag your image so you can push the image to this repository:

```
docker tag calculator:latest <aws_account_number>.dkr.ecr.<region>.amazonaws.com/calculator:latest
```

### Run the following command to push this image to your newly created AWS repository

```
docker push <aws_account_number>.dkr.ecr.<region>.amazonaws.com/calculator:latest
```





