### build
```bash
docker build -t zsu58/jupyter-scala .
```

### run
```bash
docker container run -it \
  -d \
  -p 10000:8888 \
  -e LC_ALL=C.UTF-8 \
  -e GRANT_SUDO=yes \
  --name jupyter-scala \
  -v $(pwd):/home/jovyan/work \
  zsu58/jupyter-scala:latest
```

### get token
```bash
docker container exec -it jupyter-scala bash
jupyter server list
```