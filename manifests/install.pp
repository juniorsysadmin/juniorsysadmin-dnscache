# == Class: dnscache::install
#
# Module to install dnscache.
#
class dnscache::install inherits dnscache {

  package { 'dnscache':
    ensure => $dnscache::package_ensure,
    name   => $dnscache::package_name,
  }
}
