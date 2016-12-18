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
  $dnscache_service_dir            = $dnscache::params::dnscache_service_dir,
  $env_group                       = $dnscache::params::env_group,
  $env_mode                        = $dnscache::params::env_mode,
  $env_owner                       = $dnscache::params::env_owner,
  $forwardonly                     = $dnscache::params::forwardonly,
  $gid                             = $dnscache::params::gid,
  $hidettl                         = $dnscache::params::hidettl,
  $ipsend                          = $dnscache::params::ipsend,
  $listen_ip                       = $dnscache::params::listen_ip,
  $log_account                     = $dnscache::params::log_account,
  $log_mode                        = $dnscache::params::log_mode,
  $mergequeries                    = $dnscache::params::mergequeries,
  $package_ensure                  = $dnscache::params::package_ensure,
  $package_name                    = $dnscache::params::package_name,
  $root_servers                    = $dnscache::params::root_servers,
  $root_server_ips                 = $dnscache::params::root_server_ips,
  $service_enable                  = $dnscache::params::service_enable,
  $service_ensure                  = $dnscache::params::service_ensure,
  $service_hasrestart              = $dnscache::params::service_hasrestart,
  $service_hasstatus               = $dnscache::params::service_hasstatus,
  $service_manage                  = $dnscache::params::service_manage,
  $service_name                    = $dnscache::params::service_name,
  $service_provider                = $dnscache::params::service_provider,
  $uid                             = $dnscache::params::uid,
  $uses_conf_file                  = $dnscache::params::uses_conf_file,
) inherits dnscache::params {

  validate_bool($uses_conf_file)

  # These checks are for the Redhat osfamily only

  if $uses_conf_file {

    validate_absolute_path($config_file)
    validate_string($config_file_group)
    validate_re($config_file_mode, '[0-7]{3}')
    validate_string($config_file_owner)
    validate_string($config_file_template)

    if $debug_level {
      validate_re($debug_level, '[0-3]{1}')
    }

    validate_string($gid)
    validate_array($listen_ip)

    if $mergequeries {
      validate_re($mergequeries, '[0-1]{1}')
    }

    validate_string($uid)

  }

  # These checks are for the Debian osfamily only

  else {

    validate_re($config_log_run_script_mode, '[0-7]{3}')
    validate_string($config_log_run_script_template)
    validate_string($dnscache_account)
    validate_array($listen_ip)
    if (size($listen_ip) != 1) {
      fail("The dnscache package on a ${::osfamily} based system only supports one listening address.")
    }

    validate_string($log_account)

  }

  # These checks are for any osfamily

  validate_array($accept_net)

  if (!is_integer($cachesize)) {
    fail("${cachesize} is not an integer.")
  }

  if (!is_integer($datalimit)) {
    fail("${datalimit} is not an integer.")
  }

  validate_absolute_path($dnscache_root)
  validate_absolute_path($dnscache_service_dir)
  validate_string($env_group)
  validate_re($env_mode, '[0-7]{3}')
  validate_string($env_owner)

  if $forwardonly {
    validate_re($forwardonly, '[1]{1}')
    $forwardonlyfile = 'present'
  }

  else {
    $forwardonlyfile = 'absent'
  }

  if $hidettl {
    validate_re($hidettl, '[1]{1}')
    $hidettlfile = 'present'
  }

  else {
    $hidettlfile = 'absent'
  }

  validate_string($ipsend)
  validate_string($package_ensure)
  validate_array($package_name)
  validate_absolute_path($root_servers)
  validate_array($root_server_ips)
  validate_bool($service_enable)
  validate_bool($service_enable)
  validate_bool($service_hasrestart)
  validate_bool($service_hasstatus)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($service_provider)

  contain '::dnscache::install'
  contain '::dnscache::config'
  contain '::dnscache::service'

  Class['::dnscache::install'] ->
  Class['::dnscache::config'] ~>
  Class['::dnscache::service']

}
