# == Class: dnscache::params
#
# Default parameter values for the dnscache module
#
class dnscache::params {
  $accept_net                     = ['127.0.0.1']
  $config_file                    = '/etc/ndjbdns/dnscache.conf'
  $config_file_group              = '0'
  $config_file_mode               = '0644'
  $config_file_owner              = '0'
  $config_file_template           = 'dnscache/dnscache.conf.erb'
  $config_log_run_script_mode     = '0755'
  $config_log_run_script_template = 'dnscache/dnscache-log-run.erb'
  $config_run_script_mode         = '0755'
  $config_run_script_template     = 'dnscache/dnscache-run.erb'
  $debug_level                    = '1'
  $dnscache_account               = 'Gdnscache'
  $dnscache_service_dir           = '/etc/sv/dnscache'
  $env_group                      = '0'
  $env_mode                       = '0644'
  $env_owner                      = '0'
  $forwardonly                    = nil
  $gid                            = '2'
  $hidettl                        = nil
  $ipsend                         = '0.0.0.0'
  $listen_ip                      = ['127.0.0.1']
  $log_account                    = 'Gdnslog'
  $log_mode                       = '0755'
  $mergequeries                   = '1'
  $package_ensure                 = 'present'
  $root_servers_source            = 'puppet:///modules/dnscache/root_servers'
  $service_enable                 = true
  $service_ensure                 = 'running'
  $service_manage                 = true
  $uid                            = '2'

  case $::osfamily {
    'RedHat': {
      $cachesize            = '5000000'
      $datalimit            = '8000000'
      $dnscache_root        = '/etc/ndjbdns'
      $package_name         = ['ndjbdns']
      $root_servers         = '/etc/ndjbdns/servers/roots'
      $service_name         = 'dnscache'
      $uses_conf_file       = true

      if ($::operatingsystem == 'Fedora') {
        $service_hasrestart = false
        $service_hasstatus  = false
        $service_provider   = 'systemd'
      }

      else {
        $service_hasrestart = true
        $service_hasstatus  = true
        $service_provider   = 'redhat'
      }

    }
    'Debian': {
      $cachesize            = '1000000'
      $datalimit            = '3000000'
      $dnscache_root        = '/etc/sv/dnscache/root'
      $package_name         = ['dnscache-run']
      $root_servers         = '/etc/sv/dnscache/root/servers/@'
      $service_name         = 'dnscache'
      $service_hasrestart   = true
      $service_hasstatus    = true
      $service_provider     = 'daemontools'
      $uses_conf_file       = false
    }

    default: {
      fail("The ${module_name} module is not supported on a ${::osfamily} based system.")
    }
  }
}
