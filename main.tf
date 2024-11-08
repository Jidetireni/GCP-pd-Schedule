resource "google_compute_disk" "pd_disk" {
  name  = var.disk_name
  type  = "pd-balanced"
  zone  = var.zone
  size = var.disk_size

}

resource "google_compute_resource_policy" "snapsot_schedule" {
  name   = var.snapshot_name
  region = var.region
  snapshot_schedule_policy {
    schedule {
      weekly_schedule {
        day_of_weeks {
          day = "SUNDAY"
          start_time = "00:00"
        }
      }
    }
    retention_policy {
      max_retention_days    = 10
      on_source_disk_delete = "APPLY_RETENTION_POLICY"
    }
  }
}

resource "google_compute_disk_resource_policy_attachment" "attach-retention_policy" {
  name = google_compute_resource_policy.snapsot_schedule.name 
  disk = google_compute_disk.pd_disk.name
  zone = var.zone
}

resource "google_compute_instance" "pd-instance" {
  name               = var.instance_name
  machine_type       = var.machine_type
  zone               = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
      size  = var.boot_disk_size
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {
      
    }
  }
  lifecycle {
    ignore_changes = [attached_disk]
  }

}

resource "google_compute_attached_disk" "attach-disk" {
  disk     = google_compute_disk.pd_disk.id
  instance = google_compute_instance.pd-instance.id
}
