# -- Building the Images

SPARK_VERSION="3.1.2"
HADOOP_VERSION="3.2"
JUPYTERLAB_VERSION="2.2.6"

# cluster-base
docker build --no-cache \
  -f cluster-base.Dockerfile \
  -t cluster-base .

# spark-base
docker build --no-cache \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f spark-base.Dockerfile \
  -t spark-base .

# spark-master
docker build --no-cache \
  -f spark-master.Dockerfile \
  -t spark-master .

# spark-worker
docker build --no-cache \
  -f spark-worker.Dockerfile \
  -t spark-worker .

# jupyterlab
docker build \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f jupyterlab.Dockerfile \
  -t jupyterlab .
