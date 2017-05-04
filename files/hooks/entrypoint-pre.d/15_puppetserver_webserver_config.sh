#!/bin/sh

cat <<EOF > /etc/puppetlabs/puppetserver/conf.d/webserver.conf
webserver: {
    access-log-config: /etc/puppetlabs/puppetserver/request-logging.xml

    client-auth: want

    ssl-host: 0.0.0.0
    ssl-port: ${PUPPETSERVER_PORT}

    ssl-cert: ${PUPPETSERVER_SSL_CERT}
    ssl-key: ${PUPPETSERVER_SSL_KEY}
    ssl-ca-cert: ${PUPPETSERVER_SSL_CA_CERT}
}
EOF

[ "${PUPPETSERVER_SSL_CERT}" == "" ] && sed -i -e '/ssl-cert:/d' /etc/puppetlabs/puppetserver/conf.d/webserver.conf
[ "${PUPPETSERVER_SSL_KEY}" == "" ] && sed -i -e '/ssl-key:/d' /etc/puppetlabs/puppetserver/conf.d/webserver.conf
[ "${PUPPETSERVER_SSL_CA_CERT}" == "" ] && sed -i -e '/ssl-ca-cert:/d' /etc/puppetlabs/puppetserver/conf.d/webserver.conf
