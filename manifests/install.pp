# == Class: dnscache::install
#
# Module to install dnscache.
#
class dnscache::install inherits dnscache {

  if ($::osfamily == 'Debian' and $::operatingsystem != 'Ubuntu') {
    include '::apt'

    if ! defined_with_params(Apt::Source['debian_unstable'], {'release' => 'unstable' }) {
      include '::apt::debian::unstable'
    }

    Class['::apt'] -> Apt::Force[$dnscache::package_name]

    apt::force { $dnscache::package_name:
      release => 'unstable',
      require => Apt::Source['debian_unstable'],
    }

    Apt::Force[$dnscache::package_name] -> Package['dnscache']
  }

  package { 'dnscache':
    ensure => $dnscache::package_ensure,
    name   => $dnscache::package_name,
  }
}
