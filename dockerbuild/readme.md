# Docker Image for Chocolatey on Ubuntu

## Overview

This repository contains the necessary files and instructions to build a Docker image with Chocolatey installed on an Ubuntu base image. Chocolatey is a package manager for Windows, and this setup is intended for scenarios where you might need to use Chocolatey within a Docker container running Ubuntu.

## Prerequisites

Before you can build the Docker image, you need to have the following prerequisites:
docker installed on your machine. You can download and install Docker from the official website: https://www.docker.com/products/docker-desktop
if you are using Windows, you need to have WSL 2 installed and configured. You can follow the instructions here: https://docs.microsoft.com/en-us/windows/wsl/install


## Building the Docker Image

To build the Docker image, follow these steps:

1. **Clone the Repository**

   If you haven't already, clone the repository to your local machine:

   ```
   git clone https://github.com/HealisticEngineer/chocolatey-packages.git
   cd chocolatey-packages/dockerbuild
   ```

2. **Build the Docker Image**

   Run the following command to build the Docker image:

   ```
   docker build -t choco:latest-ubuntu -f .\Dockerfile_ubuntu .
   ```

   This command will build the Docker image with the tag `choco:latest-ubuntu`.

3. **Verify the Image**

   You can verify that the image was built successfully by running:

   ```
   docker images
   ```

   You should see the `choco:latest-ubuntu` image in the list.

## Running the Docker Container

To run the Docker container, you can use the following command:

```
docker run -it --rm choco:latest-ubuntu
```
