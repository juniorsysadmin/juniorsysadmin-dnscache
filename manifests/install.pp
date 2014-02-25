# == Class: dnscache::install
#
# Module to install dnscache.
#
class dnscache::install inherits dnscache {

  case $::osfamily {
    'Redhat': {
      if ($::operatingsystem != 'Fedora') {
        include '::epel'
        Class['::epel'] -> Package['dnscache']
      }
    }

    'Debian': {
      if ($::operatingsystem != 'Ubuntu') {
        include '::apt'
        apt::force { 'dnscache-run':
        release => 'unstable',
        require => Apt::Source['debian_unstable'],
        }
        Class['::apt'] -> Package['dnscache']
      }
    }

    default: {
      fail("The ${module_name} module is not supported on a ${::osfamily}")
    }
  }

  package { 'dnscache':
    ensure => $dnscache::package_ensure,
    name   => $dnscache::package_name,
  }
}