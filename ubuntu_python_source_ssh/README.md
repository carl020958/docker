### build
docker build -t zsu58/ubuntu-python-ssh:18.04-3.8.10 .

### run
docker container run \
-d \
-e LC_ALL=C.UTF-8 \
--network {network_name} \
--name {name} \
zsu58/ubuntu-python-ssh:18.04-3.8.10