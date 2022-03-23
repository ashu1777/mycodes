/*
resource "google_compute_instance_template" "appserver-2" {
  name        = "my-template2"
  description = "This template is used to create app server instances."

  tags = ["foo", "bar"]

  labels = {
    environment = "dev"
  }
  instance_description = "description assigned to instances"
  machine_type         = "f1-micro"
  can_ip_forward       = true
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  // Create a new boot disk from an image
  disk {
    source_image      = data.google_compute_image.temp_image.self_link
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
  metadata_startup_script = "sudo yum install httpd -y && sudo systemctl restart httpd && echo 'hello ashu' > /var/www/html/index.html"
  metadata = {
    foo = "bar"
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "mukul-lambda-test@ctint2020.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

data "google_compute_image" "temp_image" {
  family  = "centos-stream-8"
  project= "centos-cloud"
}
*/