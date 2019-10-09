if mdata-get vfstab 1>/dev/null 2>&1; then
  # ensure we cannot write into the
  # folder before mounting it!
  mkdir -p /home/gogs/gogs-repositories
  chmod 0550 /home/gogs/gogs-repositories
fi