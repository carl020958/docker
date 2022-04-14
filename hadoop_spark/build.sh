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
