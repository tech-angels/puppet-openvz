class openvz::params {
  # Constants
  $openvz_conf_dir = "/etc/vz/conf"
  $openvz_conf_file = "/etc/vz/vz.conf"

  # OS dependant actions
  $fix_hosts = $lsbdistid ? {
    /(CentOS|RedHat)/ => true,
    Debian         => false,
  }

  $fix_resolve = true
}
