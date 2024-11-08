# GCP Persistent Disk and Snapshot Schedule with Terraform

This Terraform configuration sets up a Google Cloud environment with a virtual machine instance, a persistent disk with a snapshot schedule, and automatically attaches the disk to the instance. The setup is designed to provide regular backups, ensure data retention, and maintain configuration flexibility for disk types, sizes, and regions.

## Resources Created

1. **Persistent Disk** (`google_compute_disk`): Creates a balanced persistent disk with user-defined name, size, and zone.
2. **Snapshot Schedule** (`google_compute_resource_policy`): Defines a weekly snapshot schedule policy, taking snapshots every Sunday at midnight, with a retention period of 10 days.
3. **Disk Attachment** (`google_compute_disk_resource_policy_attachment`): Attaches the snapshot policy to the persistent disk.
4. **Compute Instance** (`google_compute_instance`): Creates a Google Cloud VM instance with Ubuntu 20.04 LTS, configured with a boot disk.
5. **Attach Disk to Instance** (`google_compute_attached_disk`): Attaches the created persistent disk to the VM instance.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- A [Google Cloud Platform (GCP) account](https://cloud.google.com/).
- A GCP project with billing enabled and API access to Compute Engine.

## Usage

1. **Clone this repository**:

   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Set up GCP authentication**:

   Export your Google Cloud authentication credentials:

   ```bash
   export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/service-account-file.json"
   ```

3. **Initialize Terraform**:

   Initialize the Terraform configuration:

   ```bash
   terraform init
   ```

4. **Define Variables**:

   Create a `terraform.tfvars` file or set environment variables to define the following required variables for example:

   ```hcl
   disk_name      = "example-disk"      # Name of the persistent disk
   disk_size      = 50                  # Size of the persistent disk (in GB)
   snapshot_name  = "example-snapshot"  # Name of the snapshot policy
   zone           = "us-central1-a"     # Zone for the disk and VM
   region         = "us-central1"       # Region for the snapshot policy
   instance_name  = "example-instance"  # Name of the VM instance
   machine_type   = "e2-medium"         # Machine type for the VM instance
   boot_disk_size = 20                  # Size of the VM boot disk (in GB)
   ```

5. **Apply the Configuration**:

   Deploy the resources to GCP with:

   ```bash
   terraform apply
   ```

   Confirm the operation by typing `yes` when prompted.

6. **Access the Instance**:

   Once the configuration is applied, you can access the VM instance via SSH through the GCP Console or CLI.

## Important Notes

- **Disk Types**: The configuration uses `pd-balanced` for the attached disk and `pd-standard` for the boot disk. Adjust as necessary depending on your cost and performance requirements.
- **Snapshot Schedule**: The snapshot policy retains snapshots for 10 days and takes snapshots weekly on Sundays at 00:00 UTC.
- **Ignore Changes**: The configuration includes a lifecycle rule to ignore changes to attached disks on the instance, ensuring stability when managing multiple disk attachments.
- **Additions**: There is also a script to partition, format and mount the disk to an existing vm instance.

## Clean Up

To delete the resources created by this Terraform configuration, run:

```bash
terraform destroy
```

Confirm the operation by typing `yes` when prompted.
