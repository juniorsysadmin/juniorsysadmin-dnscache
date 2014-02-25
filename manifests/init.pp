# == Class: dnscache
#
# Module to install djbdns's dnscache from package.
#
# === Parameters
#
# [*accept_net*]
#   An array listing of IP addresses or subnets that are written out to
#   $dnscache_root/ip/ as separate files. The dnscache daemon accepts
#   DNS requests from these IP/subnet addresses.
#   Defaults to ['127.0.0.1']
#
# [*cachesize*]
#   CACHESIZE dnscache environment variable
#   Defaults to distribution default value.
#
# [*config_file*]
#   Location of the dnscache.conf file used by ndjbdns (osfamily: Redhat)
#   Defaults to /etc/ndjbdns/dnscache.conf
#
# [*config_file_group*]
#   Group for the dnscache.conf file used by the ndjbdns package
#   (osfamily: Redhat)
#   Defaults to 0
#
# [*config_file_mode*]
#   File permissions for /etc/ndjbdns/dnscache.conf (osfamily: Redhat)
#   Defaults to 0644
#
# [*config_file_owner*]
#   Owner of /etc/ndjbdns/dnscache.conf (osfamily: Redhat)
#   Defaults to 0
#
# [*config_file_template*]
#   Location of the template that modifies /etc/ndjbdns/dnscache.conf
#   (osfamily: Redhat)
#   Defaults to dnscache/dnscache.conf.erb
#
# [*config_log_run_script_mode*]
#   File permissions for the ${dnscache_root}/env/run script that invokes
#   multilog (osfamily: Debian)
#   Defaults to 0755
#
# [*config_log_run_script_template*]
#   Location of the template that modifies the original script in
#   ${dnscache_root}/env/log/run (osfamily: Debian)
#   Defaults to dnscache/dnscache-log-run.erb
#
# [*config_run_script_mode*]
#   File permissions for the ${dnscache_root}/log/run script that invokes
#   dnscache (osfamily: Debian)
#   Defaults to 0755
#
# [*config_run_script_template*]
#   Location of the template that modifies the original script in
#   ${dnscache_root}/env/run (osfamily: Debian)
#   Defaults to dnscache/dnscache-run.erb
#
# [*datalimit*]
#   DATALIMIT dnscache environment variable
#   Defaults to distribution default value.
#
# [*debug_level*]
#   DEBUG_LEVEL dnscache environment variable (osfamily: Redhat)
#   Defaults to 1
#
# [*dnscache_account*]
#   Account under which dnscache is invoked via ${dnscache_root/env/run
#   (osfamily: Debian)
#   Defaults to Gdnscache
#
# [*dnscache_root*]
#   ROOT dnscache environment variable
#   Defaults to /etc/sv/dnscache/root (osfamily: Debian) or
#   /etc/ndjbdns (osfamily: Redhat)
#
# [*env_group*]
#   Group for dnscache environment files placed in ${dnscache_root}/env
#   (osfamily: Debian) and also $accept_net IPs placed in ${dnscache_root}/ip/
#   (osfamily: Debian and Redhat)
#   Defaults to 0
#
# [*env_mode*]
#   File permissions for dnscache environment files placed in
#   ${dnscache_root/env (osfamily: Debian) and also $accept_net IPs placed
#   in ${dnscache_root}/ip/ (osfamily: Debian and Redhat)
#   Defaults to 0644
#
# [*env_owner*]
#   Owner of dnscache environment files placed in
#   ${dnscache_root/env (osfamily: Debian) and also $accept_net IPs placed
#   in ${dnscache_root}/ip/ (osfamily: Debian and Redhat)
#   Defaults to 0
#
# [*forwardonly*]
#   FORWARDONLY dnscache environment variable
#   Defaults to undef
#
# [*gid*]
#   gid that will be acquired by dnscache (osfamily: Redhat)
#   Defaults to 2
#
# [*hidettl*]
#   HIDETTL dnscache environment variable
#   Defaults to undef
#
# [*ipsend*]
#   IPSEND dnscache environment variable
#   Defaults to '0.0.0.0'
#
# [*listen_ip*]
#   IP dnscache environment variable
#   Defaults to $::ipaddress
#
# [*log_account*]
#   Account that will be used to run multilog for dnscache. Must have a UID
#   and GID (osfamily: Debian)
#   Defaults to Gdnslog
#
# [*mergequeries*]
#   MERGEQUERIES dnscache environment variable (osfamily: Redhat)
#   Defaults to 1
#
# [*package_ensure*]
#   Sets the dnscache package to be installed. Can be set to 'present',
#   'latest', or a specific version. Defaults to present.
#
# [*package_name*]
#   Determines the name of the package to install. Defaults to dnscache-run
#   (osfamily: Debian) or ndjbdns (osfamily Redhat).
#
# [*service_enable*]
#   Determines if the service should be enabled at boot. Defaults to true.
#
# [*service_ensure*]
#   Determines if the service should be running or not. Defaults to running.
#
# [*service_hasrestart*]
#   Default dependent on $::operatingsystem
#
# [*service_hasstatus*]
#   Default dependent on $::operatingsystem
#
# [*service_name*]
#   Selects the name of the dnscache service for Puppet to manage. Defaults to
#   dnscache
#
# [*service_provider*]
#   Defaults to daemontools (osfamily: Debian), systemd
#   (operatingsystem: Fedora) or redhat (osfamily: Redhat)
#
# [*uid*]
#   uid that will be acquired by dnscache (osfamily: Redhat)
#   Defaults to 2
#
# [*uses_conf_file*]
#   Boolean to indicate whether most dnscache environment variables have been
#   placed in a conf file like ndjbdns or the original djbdns environment file
#   layout is being used
#   Defaults to true (osfamily: Redhat) or false (osfamily: Debian)
#
# [*use_dbndns*]
#   Unused and reserved for future use should we want to use the Debian dbndns
#   package rather than dnscache-run

class dnscache (
  $accept_net                      = $dnscache::params::accept_net,
  $cachesize                       = $dnscache::params::cachesize,
  $config_file                     = $dnscache::params::config_file,
  $config_file_group               = $dnscache::params::config_file_group,
  $config_file_mode                = $dnscache::params::config_file_mode,
  $config_file_owner               = $dnscache::params::config_file_owner,
  $config_file_template            = $dnscache::params::config_file_template,
  $config_log_run_script_mode      = $dnscache::params::config_log_run_script_mode,
  $config_log_run_script_template  = $dnscache::params::config_log_run_script_template,
  $config_run_script_mode          = $dnscache::params::config_run_script_mode,
  $config_run_script_template      = $dnscache::params::config_run_script_template,
  $datalimit                       = $dnscache::params::datalimit,
  $debug_level                     = $dnscache::params::debug_level,
  $dnscache_account                = $dnscache::params::dnscache_account,
  $dnscache_root                   = $dnscache::params::dnscache_root,
  $env_group                       = $dnscache::params::env_group,
  $env_mode                        = $dnscache::params::env_mode,
  $env_owner                       = $dnscache::params::env_owner,
  $forwardonly                     = $dnscache::params::forwardonly,
  $gid                             = $dnscache::params::gid,
  $hidettl                         = $dnscache::params::hidettl,
  $ipsend                          = $dnscache::params::ipsend,
  $listen_ip                       = $dnscache::params::listen_ip,
  $log_account                     = $dnscache::params::log_account,
  $mergequeries                    = $dnscache::params::mergequeries,
  $package_ensure                  = $dnscache::params::package_ensure,
  $package_name                    = $dnscache::params::package_name,
  $service_enable                  = $dnscache::params::service_enable,
  $service_ensure                  = $dnscache::params::service_ensure,
  $service_hasrestart              = $dnscache::params::service_hasrestart,
  $service_hasstatus               = $dnscache::params::service_hasstatus,
  $service_name                    = $dnscache::params::service_name,
  $service_provider                = $dnscache::params::service_provider,
  $uid                             = $dnscache::params::uid,
  $uses_conf_file                  = $dnscache::params::uses_conf_file,
  $use_dbndns                      = $dnscache::params::use_dbndns
) inherits dnscache::params {

  validate_bool($uses_conf_file)

  if $uses_conf_file {

    validate_absolute_path($config_file)
    validate_string($config_file_group)
    validate_re($config_file_mode, '[0-7]{3}')
    validate_string($config_file_owner)
    validate_string($config_file_template)

    if !is_integer($debug_level) {
      fail("${debug_level} is not an integer.")
    }

    validate_string($gid)

    if (!is_integer($mergequeries)) {
    fail("${mergequeries} is not an integer.")
    }

    validate_string($uid)

  }

  else {

    validate_re($config_log_run_script_mode, '[0-7]{3}')
    validate_string($config_log_run_script_template)
    validate_string($dnscache_account)
    validate_string($log_account)
    validate_bool($use_dbndns)

  }

  validate_array($accept_net)

  if (!is_integer($cachesize)) {
    fail("${cachesize} is not an integer.")
  }

  if (!is_integer($datalimit)) {
    fail("${datalimit} is not an integer.")
  }

  validate_absolute_path($dnscache_root)
  validate_string($env_group)
  validate_re($env_mode, '[0-7]{3}')
  validate_string($env_owner)

  if $forwardonly != nil {

    if !is_integer($forwardonly) {
    fail("${forwardonly} is not an integer.")
    }

  }

  if $hidettl != nil {

    if !is_integer($hidettl) {
    fail("${hidettl} is not an integer.")
    }

  }

  validate_string($ipsend)
  validate_array($listen_ip)
  validate_string($package_ensure)
  validate_array($package_name)
  validate_bool($service_enable)
  validate_bool($service_enable)
  validate_bool($service_hasrestart)
  validate_string($service_hasstatus)
  validate_string($service_name)
  validate_string($service_provider)

  anchor { 'dnscache::begin': } ->
  class { '::dnscache::install': } ->
  class { '::dnscache::config': } ~>
  class { '::dnscache::service': } ->
  anchor { 'dnscache::end': }

}