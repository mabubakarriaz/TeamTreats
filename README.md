# Team Treats

A web app to maintain the team's recreational fund (TRF)

## Technologies

`ASP.Net Core`, `Vagrant`, `Packer`, `Ansible`

## Outline

- Running the app with Docker Build
- Running the app with Docker Compose
- Running the App with Vagrant

## Running the app with Docker Build

This document provides a step-by-step guide on building a Docker image for the TeamTreats web application, running a Docker container, and pushing the image to GitHub Packages.

### Prerequisites

Before proceeding, make sure you have the following:

- [Docker](https://www.docker.com/products/docker-desktop/)
- GitHub Personal Access Token with appropriate permissions

### Steps

1. **Login to GitHub Packages (Optional):**  
   Use the following command to log in to GitHub Packages using your GitHub username and Personal Access Token.

   ```powershell
   echo $ENV:TeamTreats_GH_TOKEN | docker login ghcr.io -u mabubakarriaz --password-stdin
   ```

2. **Build Docker Image:**  
   Run the following command to build the Docker image for the TeamTreats web application. You can use any tag `-t teamtreats:latest` if you do not want to publish it to GitHub.

   ```powershell
   docker build -t ghcr.io/mabubakarriaz/teamtreats:latest -f .\teamtreats-webapp\Dockerfile .
   ```

3. **Push Docker Image to GitHub Packages (Optional):**  
   Push the built Docker image to GitHub Packages using the following command.s

   ```powershell
   docker push ghcr.io/mabubakarriaz/teamtreats:v0.0.1-alpha
   ```

4. **Pull Docker Image (Optional):**  
   If needed, pull the Docker image from GitHub Packages using the following command.

   ```powershell
   docker pull ghcr.io/mabubakarriaz/teamtreats:v0.0.1-alpha
   ```

5. **Run Docker Container:**  
   Start a Docker container for the TeamTreats web application using the following command. Use your own tag `teamtreats:latest` if building local image.

   ```powershell
   docker run --name teamtreats_webapp --restart always -d -p 8080:80 -e ASPNETCORE_ENVIRONMENT=Development ghcr.io/mabubakarriaz/teamtreats:v0.0.1-alpha
   ```

6. **Access TeamTreats Web Application:**  
   Once the container is running, access the TeamTreats web application by navigating to `http://localhost:8080` in your web browser.

### Notes

- This example uses the image tagging convention for GitHub Publish. You can use your own tag name if this is not required.
- Ensure that your GitHub Personal Access Token has the necessary permissions to read and write packages.
- Modify the version tag (`v0.0.1-alpha`) according to your versioning strategy.
- Adjust the container port (`-p 8080:80`) based on your desired host and container port configuration.
- Review and update the Dockerfile path (`.\teamtreats-webapp\Dockerfile`) if it's located in a different directory.

Congratulations! You have successfully built, deployed, and run the TeamTreats web application using Docker and GitHub Packages.

## Running the app with Docker Compose

This guide provides instructions on running the TeamTreats web app using Docker Compose.

### Prerequisites

Before proceeding, ensure that these are installed on your machine.

- [Docker](https://www.docker.com/products/docker-desktop/)
- Docker Compose

To run the TeamTreats web app, follow these steps:

1. Open a terminal or command prompt in the directory containing the `docker-compose.yml` file.

2. Use the following command to start the TeamTreats web app in detached mode:

   ```powershell
   docker-compose -p teamtreats up -d
   ```

   This command initializes the containers defined in the `docker-compose.yml` file and starts the TeamTreats web app. The `-d` flag runs the containers in the background.

3. Access the TeamTreats web app by navigating to the specified URL or IP address in your web browser.

4. To stop and remove the containers associated with the TeamTreats web app, use the following command:

   ```powershell
   docker-compose down
   ```

## Running the App with Vagrant

[Vagrant](https://www.vagrantup.com/) empowers developers to create and manage lightweight, reproducible, and portable development environments, courtesy of HashiCorp. The heart of Vagrant lies in the `Vagrantfile` located in the root directory of this repository. To set up and utilize Vagrant as a `development` and `testing` environment, follow the steps outlined below.

### Dependencies

Before diving into Vagrant, ensure the following dependencies are installed:

- [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://developer.hashicorp.com/vagrant/install?product_intent=vagrant)
- Ubuntu box: `vagrant box add ubuntu/jammy64`

### Setup Process

1. **Validate Vagrantfile:**
   Ensure the Vagrant Ruby script is valid.

   ```powershell
   vagrant validate
   ```

2. **Publish Project Files:**
   Publish project files using the following command:

   ```powershell
   dotnet publish ./src/teamtreats-webapp/teamtreats-webapp.csproj -p:PublishDir=.\bin/Publish -c Release -r linux-x64 --self-contained true
   ```

3. **Create and Run Virtual Machine:**
   Start and provision the virtual machine.

   ```powershell
   vagrant up
   ```

4. **Log into Virtual Machine:**
   Access the virtual machine through SSH.

   ```powershell
   vagrant ssh
   ```

### Additional Vagrant Commands

- **Check Environment Status:**
   View the current status of the Vagrant environment.

   ```powershell
   vagrant status
   ```

- **Save/Apply Snapshots:**
  Save a checkpoint and apply/delete a checkpoint.

  ```powershell
  vagrant snapshot push    # save a checkpoint
  vagrant snapshot pop     # apply and delete a checkpoint
  ```

- **Lifecycle Management:**
  Perform start-stop actions on the Vagrant virtual machine.

  ```powershell
  vagrant destroy   # delete VM
  vagrant up        # start VM
  vagrant halt      # shutdown VM
  vagrant reload    # restart VM
  vagrant suspend   # sleep VM
  vagrant resume    # awake VM
  ```

- **Port Collision Resolution:**
  Resolve port collisions with the following command.

  ```powershell
  vagrant port
  ```

## Running the app using Packer



packer plugins
https://developer.hashicorp.com/packer/integrations

packer plugins install github.com/hashicorp/virtualbox
packer plugins install github.com/hashicorp/vagrant
packer plugins install github.com/hashicorp/ansible


setup-alpine - answers
https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html

