
resource "google_compute_forwarding_rule" "default" {
  provider              = google
  name                  = "mukul-lb"
  region                = "us-central1"
  port_range            = 80
  backend_service       = google_compute_region_backend_service.backend.id
}
resource "google_compute_region_backend_service" "backend" {
  provider              = google
  name                  = "mukul-backend"
  region                = "us-central1"
  load_balancing_scheme = "EXTERNAL"
  backend {
    group          = google_compute_region_instance_group_manager.appserver.instance_group
    balancing_mode = "CONNECTION"
    #capacity_scaler = 1.0
  }
  health_checks         = [google_compute_region_health_check.autohealing_region.id]
}
resource "google_compute_region_health_check" "autohealing_region" {
  name                = "autohealing-region-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/index.html"
    port         = "80"
  }
}