/*

== Class: openvz::server::debian

Is included when we include `openvz::server`.

It will install kernel and tools.

*/
class openvz::server::debian {

  package {["vlan", "bridge-utils"]:
    ensure => present,
  }

  package{[
    "linux-image-openvz-amd64",
    "vzctl",
    "vzdump",
    "vzquota"
    ]:
    ensure  => present,
  }
}
