# TeamTreats

A web app to maintain the team's recreational fund.

## Technology

- ASP.Net Core Web App

## Running the app with Docker Compose

This guide provides instructions on running the TeamTreats web app using Docker Compose.

### Prerequisites

Before proceeding, ensure that Docker and Docker Compose are installed on your machine.

To run the TeamTreats web app, follow these steps:

1. Open a terminal or command prompt in the directory containing the `docker-compose.yml` file.

2. Use the following command to start the TeamTreats web app in detached mode:

   ```powershell
   docker-compose -p teamtreats up -d
   ```

   This command initializes the containers defined in the `docker-compose.yml` file and starts the TeamTreats web app. The `-d` flag runs the containers in the background.

3. Access the TeamTreats web app by navigating to the specified URL or IP address in your web browser.

### Stopping and Cleaning Up

To stop and remove the containers associated with the TeamTreats web app, use the following command:

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

