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





