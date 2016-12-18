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
  $forwardonly                    = undef
  $gid                            = '2'
  $hidettl                        = undef
  $ipsend                         = '0.0.0.0'
  $listen_ip                      = ['127.0.0.1']
  $log_account                    = 'Gdnslog'
  $log_mode                       = '0755'
  $mergequeries                   = '1'
  $package_ensure                 = 'present'
  $root_server_ips                = [ '198.41.0.4',     # a.root-servers.net
                                      '192.228.79.201', # b.root-servers.net
                                      '192.33.4.12',    # c.root-servers.net
                                      '199.7.91.13',    # d.root-servers.net
                                      '192.203.230.10', # e.root-servers.net
                                      '192.5.5.241',    # f.root-servers.net
                                      '192.112.36.4',   # g.root-servers.net
                                      '198.97.190.53',  # h.root-servers.net
                                      '192.36.148.17',  # i.root-servers.net
                                      '192.58.128.30',  # j.root-servers.net
                                      '193.0.14.129',   # k.root-servers.net
                                      '199.7.83.42',    # l.root-servers.net
                                      '202.12.27.33',   # m.root-servers.net
                                      ]
  $service_enable                 = true
  $service_ensure                 = 'running'
  $service_manage                 = true
  $uid                            = '2'

  case $::osfamily {
    'RedHat': {
      $cachesize            = '5000000'
      $datalimit            = '8000000'
      $dnscache_root        = '/etc/ndjbdns'
      $package_name         = 'ndjbdns'
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
      $package_name         = 'dnscache-run'
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
