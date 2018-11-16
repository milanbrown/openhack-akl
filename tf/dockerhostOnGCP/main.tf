// Configure the Google Cloud provider
provider "google" {
  credentials = "${var.credentials}"
  project     = "${var.project}"
  region      = "${var.region}"      #this is for the always free tier - closest to NZ
}

# Create a new instance
resource "google_compute_instance" "dockins" {
  name         = "dockins"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  tags = ["http"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  # copy a local file to the remote machine
  provisioner "file" {
    source      = "dockerinstall.sh"
    destination = "/tmp/dockerinstall.sh"

    connection {
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.private_key)}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/dockerinstall.sh",
      "/tmp/dockerinstall.sh args",
    ]

    connection {
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.private_key)}"
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}