#FROM centos:latest
FROM jameseckersall/docker-centos-base

MAINTAINER James Eckersall <james.eckersall@gmail.com>

COPY files /

RUN \
  yum install -y epel-release centos-release-scl https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm && \
  yum install -y puppetserver && \
  yum install -y rh-ruby23-ruby rh-ruby23-ruby-devel rh-ruby23-rubygems git && \
  yum install -y cmake make gcc gcc-c++ && \
  scl enable rh-ruby23 "gem install sinatra r10k thin --no-ri --no-rdoc" && \
  yum remove -y gcc gcc-c++ cmake make cpp glibc-devel glibc-headers kernel-headers libgomp libmpc libstdc++-devel mpfr && \
  chmod 0777 -R /var/log /run /etc/passwd /etc/puppetlabs

ENV \
  WEBHOOK_PORT=8080 \
  CA_ENABLED=1 \
  PUPPETSERVER_PORT=8140 \
  PUPPETSERVER_SSL_CERT="" \
  PUPPETSERVER_SSL_KEY="" \
  PUPPETSERVER_SSL_CA_CERT="" \
  GIT_CONTROL_REPO_VERIFY_HOST_FINGERPRINT=1 \
  GIT_CONTROL_REPO_TYPE=ssh \
  GIT_CONTROL_REPO_HOST_SSH_FINGERPRINT="" \
  GIT_CONTROL_REPO_USER=git \
  GIT_CONTROL_REPO_HOST=git.public.glo.gb \
  GIT_CONTROL_REPO_PATH=James.eckersall/puppettest.git \
  HOME=/tmp

EXPOSE ${WEBHOOK_PORT} ${PUPPETSERVER_PORT}

# curl -k https://localhost:8140/status/v1/services
# {"status-service":{"service_version":"0.3.5","service_status_version":1,"detail_level":"info","state":"running","status":{}}}
