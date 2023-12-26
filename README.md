# Team Treats

A web app to maintain the team's recreational fund (TRF)

## Technologies

`ASP.Net Core`, `Vagrant`, `Packer`, `Ansible`

## Outline

- [Team Treats](#team-treats)
  - [Technologies](#technologies)
  - [Outline](#outline)
  - [Running the app with Docker Build](#running-the-app-with-docker-build)
    - [Prerequisites](#prerequisites)
    - [Steps](#steps)
    - [Notes](#notes)
  - [Running the app with Docker Compose](#running-the-app-with-docker-compose)
    - [Prerequisites](#prerequisites-1)
  - [Running Packer and Vagrant using Makefile](#running-packer-and-vagrant-using-makefile)
    - [Prerequisites](#prerequisites-2)
    - [Setup Process](#setup-process)
    - [Additional Notes](#additional-notes)
  - [Running the App with Packer](#running-the-app-with-packer)
    - [Dependencies](#dependencies)
    - [Setup Process](#setup-process-1)
    - [Other useful commands](#other-useful-commands)
  - [Running the App with Vagrant](#running-the-app-with-vagrant)
    - [Dependencies](#dependencies-1)
    - [Setup Process](#setup-process-2)
    - [Additional Vagrant Commands](#additional-vagrant-commands)


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

## Running Packer and Vagrant using Makefile

A Makefile is a powerful build automation tool that simplifies the execution of commands and tasks. This configuration provides documentation on utilizing a Makefile to streamline the process of running Packer and Vagrant for virtual machine provisioning. The Makefile included in this repository automates the installation of necessary plugins and the execution of Packer and Vagrant commands.

### Prerequisites

Ensure the following prerequisites are met:

- Chocolatey: [Installation Guide](https://chocolatey.org/install)
- Make: `choco install make`

### Setup Process

1. **Install Packer Plugins**:

   To install Packer plugins, execute the following command:

   ```bash
   make init
   ```

2. **Build with Packer**:

   To build the virtual machine image using Packer, run:

   ```bash
   make packer
   ```

3. **Build with Vagrant**:

   To add a Vagrant box and launch the virtual machine, execute:

   ```bash
   make vagrant
   ```

4. **Clean Up**:

   To destroy the virtual machine and remove the associated Vagrant box, run:

   ```bash
   make clean
   ```

**Note**: Ensure that Packer, Vagrant, and any other required dependencies are installed on your system before running the Makefile.

### Additional Notes

- The Makefile assumes that `packer.json` is present in the same directory.
- Before running the `vagrant` rule, ensure that the Packer build is successful and has generated the box file.
- Customize the Makefile and associated files according to your specific project requirements.

## Running the App with Packer

This Packer configuration is designed to automate the creation of a minimal Alpine Linux virtual machine. The resulting virtual machine can be used for various purposes, including development, testing, and production environments.

### Dependencies

Before running the Packer build, ensure that the required Packer plugins are installed. You can install them using the following commands:

```powershell
packer plugins install github.com/hashicorp/virtualbox
packer plugins install github.com/hashicorp/vagrant
packer plugins install github.com/hashicorp/ansible
```

For more information on Packer integrations, visit the [HashiCorp Packer Integrations](https://developer.hashicorp.com/packer/integrations) website.

### Setup Process

1. **Validate Packer file:**

    Ensure the correctness of the Packer configuration file using the following commands. Remove the -syntax-only flag to validate the entire Packer file with plugin parameters.

    ```packer validate -syntax-only packer.json```

1. **Build With Packer**

    Initiate the Packer build process using the following command. You can omit the -force flag for the first-time creation of an image using the packer.json file.

    ```packer build -force packer.json```

### Other useful commands

- Get the list of installed plugins:

    ```packer plugins installed```

- Remove a specific plugin by replacing `<plugin>` with the actual plugin name:

    ```packer plugins remove <plugin>```

<a name="vagrant"></a>

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
   dotnet publish ./src/teamtreats-webapp/teamtreats-webapp.csproj -p:PublishDir=.\bin/Publish -c Release -r linux-musl-x64 --self-contained true
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