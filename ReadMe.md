
# Kubernetes Cluster on DigitalOcean with Terraform

This project sets up a Kubernetes cluster on DigitalOcean using Terraform. It provisions one master node and one worker node with specific configurations, creates a VPC, and adds the droplets to the declared project.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine (Use terraform AMD64 binary because 386 binary have some issues)
- A DigitalOcean account
- A DigitalOcean API token
- SSH key added to your DigitalOcean account
- DigitalOcean project ID

## Project Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules
    ├── vpc
    │   ├── main.tf
    │   └── variables.tf
    └── droplet
        ├── main.tf
        └── variables.tf
└── frontend
└── backend
└── k8s      
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
region = "syd1"
master_size = "s-2vcpu-2gb"
worker_size = "s-1vcpu-1gb"
image = "ubuntu-20-04-x64"
ssh_keys = ["your_ssh_key_fingerprint"]
allowed_ports = [
   { protocol = "tcp", port_range = "22" },
  { protocol = "tcp", port_range = "6443" },
  { protocol = "tcp", port_range = "2379-2380" },
  { protocol = "tcp", port_range = "6783" },
  { protocol = "udp", port_range = "6784" },
  { protocol = "tcp", port_range = "10248-10260" },
  { protocol = "tcp", port_range = "80" },
  { protocol = "tcp", port_range = "8080" },
  { protocol = "tcp", port_range = "443" },
  { protocol = "tcp", port_range = "30000-32767" },
  { protocol = "tcp", port_range = "179" },
  { protocol = "tcp", port_range = "9099" }
]
project_id = "your_project_id"
vpc_name = "k8s-vpc"
ip_range = "10.10.10.0/24"
monitoring = true
loadbalancer_name = "Invabode"
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

6. **Install necessary tolls:**:
    - To Setup VMs for k8s, run the `common.sh` bash script on both VMs file located in `scripts`
    - And Run the `master.sh` on the master Node and get the join command return by the script and paste it on the worker node.

<!-- have to change with the frontend & backend -->
7. **Run a test Applications:**:
    - To test k8s master and worker nodes working correctly,
      - Refer to the [Frontend Deploy README](./frontend/README.md)
      - Refer to the [Backend Deploy README](./backend/README.md)


## Clean Up

To destroy the resources created by this configuration, run:

```sh
terraform destroy
```