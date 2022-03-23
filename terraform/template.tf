resource "google_compute_instance_template" "default" {
  name        = "my-template"
  description = "This template is used to create app server instances."

  tags = ["foo", "bar"]

  labels = {
    environment = "dev"
  }
  instance_description = "description assigned to instances"
  machine_type         = "e2-micro"
  can_ip_forward       = true
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  // Create a new boot disk from an image
  disk {
    source_image      = data.google_compute_image.my_image.self_link
    auto_delete       = true
    boot              = true
    // backup the disk every day
  }
  // Use an existing disk resource
  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
  metadata_startup_script = "sudo yum install httpd -y && sudo systemctl restart httpd && echo 'hello mukul' > /var/www/html/index.html"
  metadata = {
    foo = "bar"
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "juspay-poc@ctint2020.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

data "google_compute_image" "my_image" {
  family  = "centos-stream-8"
  project= "centos-cloud"
}