#!/bin/bash

set -ex

# See https://emudhra.we-have-a-problem.com/#linux

apt-get update
apt-get install -q -y ca-certificates

# For Debian/Ubuntu systems
echo "Removing eMudhra certificates from the system CA certs..."
sed -i \
  -e 's|^mozilla/emSign_ECC_Root_CA_-_G3.crt|!&|' \
  -e 's|^mozilla/Comodo_AAA_Services_root.crt|!&|' \
  /etc/ca-certificates.conf && update-ca-certificates

# Workaround for the OpenJDK from Debian or Ubuntu packages where the Java keystore
# at /etc/ssl/certs/java/cacerts is not refreshed when the system trust store changes.
#
# The following is suggested by the above reference
# rm -f /etc/ssl/certs/java/cacerts && update-ca-certificates --fresh
#
# However this is suggested by our security team, so that's what we're using:
#
# kdj: Added conditional so that this doe not fail if no JDK/JRE is installed
# kdj: Added --priority to avoid interactive prompts
#
if [ -d /var/lib/ca-certificates-java ]; then
    echo "Removing eMudhra certificates from the Java keystore..."
    touch /var/lib/ca-certificates-java/fresh
    dpkg-reconfigure --priority critical ca-certificates-java
fi
