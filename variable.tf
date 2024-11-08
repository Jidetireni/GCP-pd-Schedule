variable "project" {
  description = "project id"
  type = string
}

variable "region" {
  description = "project region"
  type = string
}

variable "zone" {
  description = "project zone"
  type = string
}

variable "disk_name" {
  description = "name of the disks"
  type = string
}

variable "disk_size" {
  description = "size of the disk"
  type = number
}

variable "snapshot_name" {
  description = "name of the snapshot"
  type = string
}

variable "instance_name" {
  description = "instance name"
  type = string
}

variable "machine_type" {
  description = "machine type"
  type = string
}

variable "boot_disk_size" {
  description = "Boot disk size in gb"
  type = number
}