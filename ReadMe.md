
# Kubernetes Cluster on DigitalOcean with Terraform

This project sets up a Kubernetes cluster on DigitalOcean using Terraform. It provisions one master node and one worker node with specific configurations.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine (Use terraform AMD64 binary because have 386 binary have some issues)
- A DigitalOcean account
- A DigitalOcean API token
- SSH key added to your DigitalOcean account
- - DigitalOcean project ID

## Project Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules
    └── droplet
        ├── main.tf
        └── variables.tf
```

- **main.tf**: The main configuration file that sets up the provider and modules for master and worker nodes.
- **variables.tf**: Declares the input variables used in the configuration.
- **outputs.tf**: Defines the outputs of the configuration, specifically the IP addresses of the master and worker nodes.
- **terraform.tfvars**: Contains the values for the variables.
- **modules/droplet**: Contains the module for creating a DigitalOcean droplet and configuring the firewall.

## Variables

### `terraform.tfvars`

```hcl
do_token = "your_digitalocean_token"
master_name = "k8s-master"
worker_name = "k8s-worker"
region = "nyc3"
master_size = "s-2vcpu-2gb"
worker_size = "s-1vcpu-1gb"
image = "ubuntu-20-04-x64"
ssh_keys = ["your_ssh_key_fingerprint"]
allowed_ports = [
  { protocol = "tcp", port_range = "6443" },
  { protocol = "tcp", port_range = "2379-2380" },
  { protocol = "tcp", port_range = "6783" },
  { protocol = "udp", port_range = "6784" },
  { protocol = "tcp", port_range = "10248-10260" },
  { protocol = "tcp", port_range = "80" },
  { protocol = "tcp", port_range = "8080" },
  { protocol = "tcp", port_range = "443" },
  { protocol = "tcp", port_range = "30000-32767" }
]
```

## Usage

1. **Initialize Terraform:**

   ```bash
   terraform init
   ```

2. **Validate Terraform Code:**

   ```bash
   terraform validate
   ```   

3. **Get the list of things Terraform Going to create:**

   ```bash
   terraform plan
   ```   


4. **Apply the configuration:**

   ```bash
   terraform apply
   ```

   Confirm the apply step by typing `yes` when prompted. Terraform will create the resources defined in the configuration.

5. **Output**:
    After running `terraform apply`, the IP addresses of the master and worker nodes will be displayed.

## Clean Up

To destroy the resources created by this configuration, run:

```sh
terraform destroy
```
