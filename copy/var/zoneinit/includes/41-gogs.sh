# Paste default environment file
echo "PATH=/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin" > \
  /home/gogs/.ssh/environment
chown gogs:gogs /home/gogs/.ssh/environment

# Enable environment configuration for users
gsed -i \
  -e 's:.*PermitUserEnvironment.*no:PermitUserEnvironment yes:g' \
  /etc/ssh/sshd_config

svccfg import /opt/local/lib/svc/manifest/gogs.xml
svcadm enable -r svc:/application/gogs:default