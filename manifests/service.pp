# == Class: dnscache::service
#
# Class to manage the dnscache service
#

class dnscache::service inherits dnscache {

  if ! ($dnscache::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if ($dnscache::service_manage == true) {

  # The dnscache service can only be 'started' on osfamily Debian if
  # daemontools is already running. Debian adds svscanboot as an /etc/inittab
  # entry and daemontools gets started after the daemontools package is
  # installed. Ubuntu adds an Upstart entry for svscan but does not
  # immediately start svscan after the daemontools package installation.

    if ($::operatingsystem == 'Ubuntu') {

      service { 'svscan':
        ensure => 'running',
        enable => true,
        before => Service['dnscache'],
      }

    }

    service { 'dnscache':
      ensure     => $dnscache::service_ensure,
      enable     => $dnscache::service_enable,
      hasrestart => $dnscache::service_hasrestart,
      hasstatus  => $dnscache::service_hasstatus,
      name       => $dnscache::service_name,
      provider   => $dnscache::service_provider,
    }
  }
}
