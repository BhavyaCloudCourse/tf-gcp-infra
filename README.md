# Terraform Infrastructure Setup

This repository contains Terraform configuration files to set up infrastructure on Google Cloud Platform (GCP). It includes configurations to create a Virtual Private Cloud (VPC) with subnets, routes, and other networking resources.

## Prerequisites

1.Before you begin, make sure you have the following prerequisites installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [Google Cloud CLI](https://cloud.google.com/sdk/docs/install)

You also need to have a GCP account and a project set up.

2.Create your Google Cloud project

3.Enable Compute Engine API in your Cloud project

## Usage

Follow these steps to set up the infrastructure using Terraform:

1. Fort this repository and clone to your local machine:

    ```bash
    git clone https://github.com/your-username/tf-gcp-infra.git
    cd your-repository
    ```

2. Initialize Terraform by running the following command:

    ```bash
    terraform init
    ```

3. Set up authentication with your GCP account by running:

    ```bash
    gcloud auth login
    ```

4. Review and modify the `variables.tf` file to customize the configuration according to your requirements.

5. Optionally, create a `.tfvars` file to specify variable values. Example:

    ```hcl
    project_id = "your-gcp-project-id"
    region     = "your-region"
    vpc_name   = "your-vpc-name"
    webapp_subnet_cidr = "/24 CIDR address range."
    db_subnet_cidr     = "/24 CIDR address range."
    ```

6. Plan the infrastructure changes:

    ```bash
    terraform plan
    ```

7. Apply the changes to create the infrastructure:

    ```bash
    terraform apply
    ```

    Type `yes` when prompted to confirm the changes.

8. Once the apply is complete, Terraform will output information about the created resources.

