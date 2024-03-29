resource "google_compute_address" "static_address" {
  name   = "ipv4-cicd-test"
  region = "us-west1"
}
resource "google_compute_instance" "web-server" {
  name         = "cit262-vm-cicd"
  project      = "secure-granite-397514"
  machine_type = "e2-medium"
  zone         = "us-west1-b"
  tags         = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_address.address
    }
  }
  metadata_startup_script = <<-SCRIPT
    #!/bin/bash
    # Update package index
    sudo apt-get update
    
    # Install Docker dependencies
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    
    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
    # Set up the stable repository
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    
    # Update package index again after adding Docker repository
    sudo apt-get update
    
    # Install Docker CE
    sudo apt-get install -y docker-ce
    
    # Add the current user to the docker group to run Docker without sudo
    sudo usermod -aG docker $USER
  SCRIPT
}
