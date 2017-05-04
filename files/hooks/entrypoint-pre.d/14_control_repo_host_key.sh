#!/bin/sh

ssh-keyscan ${GIT_CONTROL_REPO_HOST} > /tmp/control_hostkey 2>/dev/null

if [ "${GIT_CONTROL_REPO_VERIFY_HOST_FINGERPRINT}" == "1" ]; then
  fingerprint=$(ssh-keygen  -lf /tmp/control_hostkey | grep \(RSA\)$ | awk '{print $2}')
  if [ "${fingerprint}" != "${GIT_CONTROL_REPO_HOST_SSH_FINGERPRINT}" ]; then
    echo "Host key for control repo host ${GIT_CONTROL_REPO_HOST} was not verified."
    echo "Got: ${fingerprint}"
    echo "Expected: ${GIT_CONTROL_REPO_HOST_SSH_FINGERPRINT}"
    rm -f /tmp/control_hostkey >/dev/null 2>&1
    exit 1
  fi
fi

mkdir -p ~/.ssh
echo "Adding host_key:"
cat /tmp/control_hostkey
cat /tmp/control_hostkey > ~/.ssh/known_hosts
ls -l ~/.ssh/known_hosts
echo "home: $HOME"
rm -f /tmp/control_hostkey
