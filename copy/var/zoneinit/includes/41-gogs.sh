# Paste default environment file
echo "PATH=/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin" > \
  /home/gogs/.ssh/environment
chown gogs:gogs /home/gogs/.ssh/environment

# Enable environment configuration for users
gsed -i \
  -e 's:.*PermitUserEnvironment.*no:PermitUserEnvironment yes:g' \
  /etc/ssh/sshd_config

svcadm restart svc:/network/ssh:default

if mdata-get vfstab 1>/dev/null 2>&1; then
  MOUNT_FOLDER=$(mdata-get vfstab | awk '{print $3}')
  if [[ -f "${MOUNT_FOLDER}/app.ini" ]]; then
    mkdir -p home/gogs/go/src/github.com/gogs/gogs/custom/conf
    cp "${MOUNT_FOLDER}/app.ini" /home/gogs/go/src/github.com/gogs/gogs/custom/conf/app.ini
  else
    # TODO: setup app.ini via mdata if custom conf is missing
  fi
fi

svccfg import /opt/local/lib/svc/manifest/gogs.xml
svcadm enable -r svc:/application/gogs:default