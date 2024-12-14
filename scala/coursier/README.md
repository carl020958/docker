### build
```bash
docker build -t zsu58/scala .
```

### run
```bash
docker container run \
  -itd  \
  -v $(pwd):/root/dev \
  --name scala  \
  zsu58/scala
```
