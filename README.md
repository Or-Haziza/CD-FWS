# Project Setup and Deployment Guide

## Overview

This guide will help you set up an EC2 instance with Docker, Jenkins, and Ansible. You'll also configure a CI/CD pipeline to automatically build Docker images and deploy updates when you make changes to your repository. Follow the steps below to get everything running smoothly.

## Steps to Follow

### 1. Clone or Copy the Repository

Import this repository or copy the files to the exact location and folder as specified in this repository. This step is crucial as we'll attach a webhook later on.

### 2. Create and Configure Your EC2 Instance

- **Launch an EC2 Instance**: Create a new EC2 instance with Ubuntu.

- **User Data Script**: In the EC2 instance creation wizard, add the following bash script to the "User Data" section:

  ```bash
  #!/bin/bash
  apt update
  apt install -y ansible
  sudo wget https://raw.githubusercontent.com/<your_git_profile>/<your_repository_name>/main/ansible/packages-installation.yml -O /home/ubuntu/packages-installation.yml
  ansible-playbook /home/ubuntu/packages-installation.yml
  ```

  ### Note:
  Replace <your_git_profile> and <your_repository_name> with your actual GitHub profile name and repository name. This script will install Ansible on the EC2 instance, download the Ansible playbook, and execute it. The playbook will set up Docker, Docker Compose, and Jenkins.

### 3. Configure Jenkins
- Access Jenkins: After the EC2 instance setup completes, navigate to http://<your_instance_public_ip>:8080 in your web browser. Complete the Jenkins initial setup and reach the main dashboard.
- Create a New Pipeline:
- Click on "New Item".
Enter a name for your pipeline, select "Pipeline", and click "OK".
- Configure Pipeline:

- Check the box labeled "GitHub hook trigger for GITScm polling".
In the "Pipeline Definition" section, choose "Pipeline script from SCM".
For SCM, select "Git" and enter your Git repository URL.
Change "Branches to build" from "master" to "main".

### 4. Set Up GitHub Webhook
- **Create a Webhook:**
  - Go to your GitHub repository and navigate to Settings > Webhooks.
  - Click "Add webhook".
  - In the Payload URL field, enter http://<your_ec2_instance_public_ip>:8080/github-webhook/.
  - For Content type, choose "application/json".
  - Check the box labeled "Send me everything" for the triggers.
  - Click "Add webhook" to save.

### 5. Testing and Verification
- Update index.html: Make changes to your index.html file located in the src folder of your repository.

- Trigger Build: Commit your changes. This will trigger the Jenkins pipeline, which will clone the repository, build the Docker image using the nginx Dockerfile, and deploy the container.

- **Verify Deployment:**

   - Using Curl: Run curl http://localhost:80 on your EC2 instance.
   - Using Web Browser: Navigate to http://<your_ec2_instance_public_ip>:80 to view the updated webpage.
 
## Additional Notes
  - Make sure to allow HTTP inbound traffic and port 8080 in your EC2 instance's security group to access both Jenkins UI and your deployed application.
  - Ensure all necessary configurations and permissions are correctly set to avoid access issues.
