output "instance_id" {
  value = "${google_compute_instance.dockins.self_link}"
}

output "ip" {
  value = "${google_compute_instance.dockins.network_interface.0.access_config.0.assigned_nat_ip }"
}
