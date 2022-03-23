resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/index.html"
    port         = "80"
  }
}

resource "google_compute_region_instance_group_manager" "appserver" {
  name = "appserver-igm"

  base_instance_name         = "app"
  region                     = "us-central1"
  distribution_policy_zones  = ["us-central1-a", "us-central1-f","us-central1-c","us-central1-b"]

  version {
    name = "v1"
    instance_template = google_compute_instance_template.default.id
    target_size {
      fixed = 0
    }
  }
 /*  
  version {
    name = "v2"
    instance_template = google_compute_instance_template.appserver-2.id
  }
  */

  #target_pools = [google_compute_target_pool.my-pool.id]
  update_policy {
  type                         = "PROACTIVE"
  instance_redistribution_type = "PROACTIVE"
  minimal_action               = "REPLACE"
  max_surge_fixed              = 4
  max_unavailable_fixed        = 0
  min_ready_sec                = 10
}

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }


}

resource "google_compute_region_autoscaler" "appserver-autoscaler" {
  name   = "mukul-autoscaler"
  region = "us-central1"
  target = google_compute_region_instance_group_manager.appserver.id

  autoscaling_policy {
    max_replicas    = 6
    min_replicas    = 2
    cooldown_period = 60

    scale_in_control {
      time_window_sec = 180
      max_scaled_in_replicas {
        fixed = 2
      }
    }

    cpu_utilization {
      target = 0.99
    }
  }
}