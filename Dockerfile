#FROM centos:latest
FROM jameseckersall/docker-centos-base

MAINTAINER James Eckersall <james.eckersall@gmail.com>

COPY files /

RUN \
  chmod 0777 -R /var/log /run && \
  curl -4 https://yum.puppetlabs.com/RPM-GPG-KEY-puppet -o /tmp/RPM-GPG-KEY-puppet && \
  curl -4 https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs -o /tmp/RPM-GPG-KEY-puppetlabs && \
  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 /tmp/RPM-GPG-KEY-* && \
  rm /tmp/RPM-GPG-KEY-* && \
  yum install -y epel-release && \
  yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm && \
  yum install -y puppetserver && \
  yum install -y ruby

RUN \
  gem install r10k sinatra thin --no-rdoc --no-ri

ENV WEBHOOK_PORT 8080
ENV PUPPETMASTER_PORT 8140

EXPOSE ${WEBHOOK_PORT} ${PUPPETMASTER_PORT}

#ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]

# curl -k https://localhost:8140/status/v1/services
# {"status-service":{"service_version":"0.3.5","service_status_version":1,"detail_level":"info","state":"running","status":{}}}
