# == Class: dnscache::service
#
# Class to manage the dnscache service
#
class dnscache::service inherits dnscache {

  if ! ($dnscache::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  service { 'dnscache':
    ensure      => '$dnscache::service_ensure',
    enable      => '$dnscache::service_enable',
    hasrestart  => '$dnscache::service_hasrestart',
    hasstatus   => '$dnscache::service_hasstatus',
    name        => '$dnscache::service_name',
    provider    => '$dnscache::service_provider',
  }
}