FROM cluster-base
LABEL maintainer="carl020958@korea.ac.kr"

HEALTHCHECK CMD curl -f http://localhost:9000/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD ./namenode/run.sh /run.sh
RUN chmod a+x /run.sh

# # Web
# EXPOSE 50070
# # Default
# EXPOSE 8020

EXPOSE 9870

CMD ["/run.sh"]
