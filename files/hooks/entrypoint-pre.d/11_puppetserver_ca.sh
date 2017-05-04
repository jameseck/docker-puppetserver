#!/bin/sh

if [ "$CA_ENABLED" == "1" ]; then
  echo "CA is enabled"
  cat <<EOF > /etc/puppetlabs/puppetserver/services.d/ca.cfg
# To enable the CA service, leave the following line uncommented
puppetlabs.services.ca.certificate-authority-service/certificate-authority-service
# To disable the CA service, comment out the above line and uncomment the line below
#puppetlabs.services.ca.certificate-authority-disabled-service/certificate-authority-disabled-service
EOF
else
  echo "CA is disabled"
  cat <<EOF > /etc/puppetlabs/puppetserver/services.d/ca.cfg
# To enable the CA service, leave the following line uncommented
#puppetlabs.services.ca.certificate-authority-service/certificate-authority-service
# To disable the CA service, comment out the above line and uncomment the line below
puppetlabs.services.ca.certificate-authority-disabled-service/certificate-authority-disabled-service
EOF
fi
