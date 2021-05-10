# Docker image to use.
FROM sloopstash/amazonlinux:v1

# Install system packages.
RUN set -x \
  && yum update -y \
  && yum install -y wget tar gzip vim procps \
  && yum install -y libcurl openssl xz-libs

# Download and extract MongoDB.
WORKDIR /tmp
RUN set -x \
  && wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-amazon2-4.4.4.tgz --quiet \
  && tar -zxvf mongodb-linux-x86_64-amazon2-4.4.4.tgz > /dev/null \
  && cp mongodb-linux-x86_64-amazon2-4.4.4/bin/* /usr/local/bin/ \
  && rm -r mongodb-linux-x86_64-amazon2-4.4.4*

# Create necessary directories.
RUN set -x \
  && mkdir -p /opt/mongodb/data \
  && mkdir -p /opt/mongodb/log \
  && mkdir -p /opt/mongodb/conf \
  && history -c

# Set default work directory.
WORKDIR /opt/mongodb