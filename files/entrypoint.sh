#!/bin/bash

/usr/bin/java -Xms2g -Xmx2g -XX:MaxPermSize=256m -Dlogappender=STDOUT -cp /opt/puppetlabs/server/apps/puppetserver/puppet-server-release.jar clojure.main -m puppetlabs.trapperkeeper.main --config /etc/puppetlabs/puppetserver/conf.d --bootstrap-config /etc/puppetlabs/puppetserver/services.d/,/opt/puppetlabs/server/apps/puppetserver/config/services.d/
