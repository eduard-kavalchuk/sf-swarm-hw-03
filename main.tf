terraform {
  required_version = "~> 1.3.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.80.0"
    }
  }
}

provider "yandex" {
  token              = var.token
  cloud_id           = var.cloud_id
  folder_id          = var.folder_id
  zone               = "ru-central1-a"
  storage_access_key = var.storage_access_key
  storage_secret_key = var.storage_secret_key
}

resource "yandex_vpc_network" "network" {
  name = "swarm-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "swarm_cluster" {
  source        = "./instances"
  vpc_subnet_id = yandex_vpc_subnet.subnet.id
  managers      = 1
  workers       = 1
}
