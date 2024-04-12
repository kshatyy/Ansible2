resource "yandex_compute_disk" "default" {
  count = 3
  name     = "${var.storage.vm.disk.disk_name}-${count.index + 1}"
  type     = var.storage.vm.disk.disk_type
  zone     = var.storage.vm.disk.disk_zone
  size     = var.storage.vm.disk.disk_size
}

resource "yandex_compute_instance" "storage" {
  name        = var.storage.vm.instance_name
  platform_id = var.storage.vm.instance_platform_id

  zone = var.storage.vm.instance_zone

  resources {
    cores         = var.storage.vm.instance_cores
    memory        = var.storage.vm.instance_memory
    core_fraction = var.storage.vm.instance_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.storage.vm.instance_preemtable
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.storage.vm.instance_network_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.default
    content {
      device_name = "${var.storage.vm.disk.disk_name}-${secondary_disk.value.name}"
      disk_id = secondary_disk.value.id
    }
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}
