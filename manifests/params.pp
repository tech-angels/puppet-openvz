class openvz::params {
  # Constants
  $openvz_conf_dir = "/etc/vz/conf"
  $openvz_conf_file = "/etc/vz/vz.conf"

  $openvz_private_dir = $lsbdistid ? {
    /(Centos|RedHat)/ => '/vz/private',
    Debian            => '/var/lib/vz/private',
  }

  # OS dependant actions
  $fix_hosts = $lsbdistid ? {
    /(CentOS|RedHat)/ => true,
    Debian         => false,
  }

  $fix_resolve = true
}
