# == Class: dnscache::install
#
# Module to install dnscache.
#
class dnscache::install {

  package { 'dnscache':
    ensure => $dnscache::package_ensure,
    name   => $dnscache::package_name,
  }
}
