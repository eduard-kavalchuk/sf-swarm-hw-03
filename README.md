Create manager and worker nodes in Yandex cloud and use Docker swarm to deploy a [demo microservice](https://github.com/microservices-demo/microservices-demo).

### Local host
```
terraform init
terraform apply
```
Among two created VMs select one which will be a ```manager```. THe other one will be ```worker```.

### Manager node
```
curl -fsSL https://get.docker.com | sh
sudo apt install -y docker-compose
sudo docker swarm init
```
Execute the following command and save its output (which will be executed on the next step on a ```worker``` VM):
```
sudo docker swarm join-token worker
```

### Worker node
```
curl -fsSL https://get.docker.com | sh
```
Execute command produced on a previous step by ```sudo docker swarm join-token worker```:
```
sudo docker swarm join --token <token> <manager IP>:2377
```

### Local host
Copy ```docker-compose-v3.yml``` to manager.

### Manager node
```
sudo docker stack deploy --compose-file ~/docker-compose-v3.yml sockshop-swarm
sudo docker service scale sockshop-swarm_front-end=2
sudo docker service ls
sudo docker node ls
sudo docker stack rm sockshop-swarm
```
