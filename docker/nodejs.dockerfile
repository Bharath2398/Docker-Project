# Docker image to use.
FROM bharath/amazonlinux:v1

# Install system packages.
RUN set -x \
  && yum update -y \
  && yum install -y wget vim procps tar gzip xz

# Download and extract Node.js.
WORKDIR /tmp
RUN set -x \
  && wget https://nodejs.org/dist/v14.16.0/node-v14.16.0-linux-x64.tar.xz --quiet \
  && mkdir -p /usr/local/lib/nodejs \
  && tar -xJvf node-v14.16.0-linux-x64.tar.xz -C /usr/local/lib/nodejs \
  && rm node-v14.16.0-linux-x64.tar.xz

RUN set -x \
  && mkdir /opt/app \
  && mkdir /opt/app/source \
  && mkdir /opt/app/log

# Install npm packages.
WORKDIR /opt/app
ENV PATH=/usr/local/lib/nodejs/node-v14.16.0-linux-x64/bin:$PATH
ENV NODE_PATH=/opt/app/node_modules
RUN set -x \
  && npm install mongodb@3.6.5 \
  && npm install express@4.17.1

# Set default work directory.
WORKDIR /opt/app
