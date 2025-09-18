
# 🔸 Startup scripts
locals {

  deploy = {
    blue  = 0
    green = 1
  }

  swap = {
    blue  = 0
    green = 1
  }

  blue_script = <<-EOF
    #!/bin/bash
    apt update
    apt install -y apache2
    echo "<h1>Hello from BLUE</h1>" > /var/www/html/index.html
    systemctl start apache2
  EOF

  green_script = <<-EOF
    #!/bin/bash
    apt update
    apt install -y apache2
    echo "<h1>Hello from GREEN</h1>" > /var/www/html/index.html
    systemctl start apache2
  EOF
}

# 🔵 Instance Template: Blue
resource "google_compute_instance_template" "blue" {
  name         = "blue-template"
  machine_type = "e2-micro"

  disk {
    auto_delete  = true
    boot         = true
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  metadata_startup_script = local.blue_script
}

# 🟢 Instance Template: Green
resource "google_compute_instance_template" "green" {
  name         = "green-template"
  machine_type = "e2-micro"

  disk {
    auto_delete  = true
    boot         = true
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  metadata_startup_script = local.green_script
}

# 🔵 MIG: Blue
resource "google_compute_instance_group_manager" "blue" {
  name               = "blue-mig"
  zone               = var.zone
  base_instance_name = "blue"
  version {
    instance_template = google_compute_instance_template.blue.self_link
  }
  target_size = local.deploy.blue
}

# 🟢 MIG: Green
resource "google_compute_instance_group_manager" "green" {
  name               = "green-mig"
  zone               = var.zone
  base_instance_name = "green"
  version {
    instance_template = google_compute_instance_template.green.self_link
  }
  target_size = local.deploy.green
}

# 🌐 Health check
resource "google_compute_health_check" "http" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

# 🛠 Backend Service with both MIGs
resource "google_compute_backend_service" "web_backend" {
  name            = "blue-green-backend"
  protocol        = "HTTP"
  port_name       = "http"
  health_checks   = [google_compute_health_check.http.self_link]
  timeout_sec     = 10
  load_balancing_scheme = "EXTERNAL"

  backend {
    group           = google_compute_instance_group_manager.blue.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = local.swap.blue > 0 ? 1.0 : 0.0
  }

  backend {
    group           = google_compute_instance_group_manager.green.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = local.swap.green > 0 ? 1.0 : 0.0
  }
}

# 🌐 URL Map
resource "google_compute_url_map" "web_map" {
  name            = "web-map"
  default_service = google_compute_backend_service.web_backend.self_link
}

# 🌐 Target HTTP Proxy
resource "google_compute_target_http_proxy" "web_proxy" {
  name    = "web-proxy"
  url_map = google_compute_url_map.web_map.self_link
}

# 🌐 Global Forwarding Rule (HTTP)
resource "google_compute_global_forwarding_rule" "http_forward" {
  name                  = "http-forwarding-rule"
  port_range            = "80"
  target                = google_compute_target_http_proxy.web_proxy.self_link
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.web_ip.address
}

# 🌐 Reserved Static IP
resource "google_compute_global_address" "web_ip" {
  name = "blue-green-ip"
}
