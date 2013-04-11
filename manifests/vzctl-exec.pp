/*

== Definition: openvz::exec
Executes a command in container

Arguments:
- *veid*:        container ID
- *command*:     command to execute
- *creates*
- *cwd*
- *environment*
- *logoutput*
- *onlyif*
- *refresh*
- *refreshonly*
- *returns*
- *timeout*
- *tries*
- *try_sleep*
- *unless*

Examples:

openvz::exec {'do nothing in 101':
  veid       => '101',
  command    => '/bin/true',
}
*/
define openvz::vzctl-exec (
  $veid,
  $command,
  $creates = false,
  $logoutput = on_failure,
  $onlyif = false,
  $refresh = false,
  $refreshonly = false,
  $returns = 0,
  $timeout = 300,
  $tries = 1,
  $try_sleep = false,
  $unless = false,
  $private_path = false
) {
  include openvz::params
  $openvz_private_dir = $openvz::params::openvz_private_dir

  $real_private_path = $private_path ? {
    false   => "${openvz_private_dir}/${veid}",
    default => $private_path,
  }

  $real_creates = $creates ? {
    false   => undef,
    default => "${real_private_path}/${creates}"
  }

  $real_onlyif = $onlyif ? {
    false   => undef,
    default => "vzctl exec2 ${veid} ${onlyif}"
  }

  $real_refresh = $refresh ? {
    false   => undef,
    default => "vzctl exec2 ${veid} ${refresh}"
  }

  $real_unless = $unless ? {
    false   => undef,
    default => "vzctl exec2 ${veid} ${unless}"
  }

  # Escape quotes in command
  $real_command = regsubst($command, '"', '\\"', 'G')

  exec { "vzctl exec2 ${veid} \"${real_command}\"":
    creates     => $real_creates,
    logoutput   => $logoutput,
    onlyif      => $real_onlyif,
    refresh     => $real_refresh,
    refreshonly => $refreshonly,
    returns     => $returns,
    timeout     => $timeout,
    tries       => $tries,
    try_sleep   => $try_sleep ? { false => undef, default => $try_sleep },
    unless      => $real_unless,
  }
}
