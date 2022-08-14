# -- Building the Images

# base
docker build --no-cache \
  -f ./base/. \
  -t cluster-base .

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

# hive
docker build --no-cache \
  -f ./hive/. \
  -t hive .

# hive-metastore
docker build --no-cache \
  -f ./hive-metastore/. \
  -t hive-metastore .