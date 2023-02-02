terraform {
  required_version = "~> 1.3.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.80.0"
    }
  }
}

data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}


resource "yandex_compute_instance" "vm-manager" {
  count    = var.managers
  name     = "ci-sockshop-docker-swarm-manager-${count.index}"
  hostname = "manager-${count.index}"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    serial-port-enable = "1"
    user-data          = file("${path.module}/userconfig.txt")
  }
}


resource "yandex_compute_instance" "vm-worker" {
  count    = var.workers
  name     = "ci-sockshop-docker-swarm-worker-${count.index}"
  hostname = "worker-${count.index}"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    serial-port-enable = "1"
    user-data          = file("${path.module}/userconfig.txt")
  }
}
