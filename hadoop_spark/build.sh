# -- Building the Images

# base
docker build --no-cache \
  -f ./base/. \
  -t cluster-base .

# base-python
docker build --no-cache \
  -f ./base-python/. \
  -t base-python .

# datanode
docker build --no-cache \
  -f ./datanode/. \
  -t datanode .

# historyserver
docker build --no-cache \
  -f ./historyserver/. \
  -t historyserver .

# namenode
docker build --no-cache \
  -f ./namenode/. \
  -t namenode .

# nodemanager
docker build --no-cache \
  -f ./nodemanager/. \
  -t nodemanager .

# resourcemanager
docker build --no-cache \
  -f ./resourcemanager/. \
  -t resourcemanager .

# spark
docker build --no-cache \
  -f ./spark/. \
  -t spark .