# Infra Automation: Static Site Deployment with AWS, Terraform, Ansible

<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/terraform/terraform-original.svg" alt="Terraform" width="60"/>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/ansible/ansible-original.svg" alt="Ansible" width="60"/>
  <img src="https://unpkg.com/simple-icons@v9/icons/amazonaws.svg" alt="AWS" width="60"/>
</p>

## Key Highlights

- **Blazing fast provisioning** – End-to-end infrastructure creation and Nginx configuration complete in roughly 60 seconds on a typical AWS environment.
- **Fully automated** – Single-command workflow: Terraform handles infra, Ansible manages configuration and deployment with no manual intervention.  
- **Ready-to-serve Nginx** – EC2 comes up with Nginx installed, configured, and serving the static site out of the box.
- **Scalable & replicable** – The setup is defined as code, making it easy to scale out to more instances or replicate across environments (dev/stage/prod).

## Overview

This project automates the deployment of a static website on AWS using Terraform and Ansible. Terraform provisions an EC2 instance and related AWS resources, while Ansible configures Nginx on the instance and deploys the static site content.

## Cloud Architecture
<img width="855" height="587" alt="image" src="https://github.com/user-attachments/assets/71432b8a-6e4a-4618-98be-c6d544e3ba06" />


## Tech Stack

- **Terraform** – Provisioning AWS infrastructure (EC2, networking, and related resources).
- **Ansible** – Configuring the EC2 instance and managing Nginx setup.
- **AWS** – Hosting the infrastructure and serving the static site from an EC2 instance.

## Project Structure

- `main.tf`, `variables.tf`, `output.tf` – Core Terraform configuration for the EC2 instance and infrastructure.
- `ansible/` – Ansible playbooks and roles to install and configure Nginx, and deploy the static site.
- `site/` – Static website assets served by Nginx on the EC2 instance.

## High-Level Flow

1. Use Terraform to create the EC2 instance and required AWS resources.
2. Connect to the created instance and run Ansible to install and configure Nginx.
3. Deploy the static site files to the configured Nginx document root and serve the site over HTTP.

# Steps to use the template for your project:

## Pre-requisites
1) Create a key pair on AWS and store that locally under `~/.ssh/`
2) Replace the contents of the static site you want to serve from the nginx server under the `/site/` folder.
3) Have Ansible already  installed on your machine.(Steps vary for Windows and macOS. For macOS, follow the installation guide online. For Windows 11, you need to install WSL to work with Ansible and then install Ansible on it using the respective package amanger[apt, yum, dnf etc])
4) Create the `inventory.ini` file under `./ansible/` with the below contents. Add your VM's IP Address after it's provisioned using the output from Terraform and replace the name of the SSH key pair file.
   ```
   [webservers]
   <DEPLOYED_VM_IP_ADDRESS> ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/<YOU_KEY_PAIR_FILE_NAME>.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
   ```

