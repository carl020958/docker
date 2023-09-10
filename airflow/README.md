### build
```bash
docker build -t zsu58/airflow:2.0.2-3.8.10 .
```

### run
```bash
docker container run \
-d \
-e LC_ALL=C.UTF-8 \
--network {network_name} \
--name {name} \
zsu58/airflow:2.0.2-3.8.10
```