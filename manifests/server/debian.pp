/*

== Class: openvz::server::debian

Is included when we include `openvz::server`.

It will install tools.

*/
class openvz::server::debian {

  package {["vlan", "bridge-utils"]:
    ensure => present,
  }

  # Install corrected debian-add_ip.sh script
  file { '/etc/vz/dists/scripts/debian-add_ip.sh':
    source => 'puppet:///modules/openvz/debian-add_ip.sh',
  }

  package{[
    "vzctl",
    "vzdump",
    "vzquota"
    ]:
    ensure  => present,
  }
}
