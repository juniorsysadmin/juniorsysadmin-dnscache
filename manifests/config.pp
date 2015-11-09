# == Class: dnscache::config
#
class dnscache::config inherits dnscache {

  File {
    ensure => file,
    group   => $dnscache::env_group,
    mode    => $dnscache::env_mode,
    owner   => $dnscache::env_owner,
  }

  # These settings are needed for the Redhat osfamily only

  if $dnscache::uses_conf_file {

    file { $dnscache::config_file:
      content => template($dnscache::config_file_template),
      group   => $dnscache::config_file_group,
      mode    => $dnscache::config_file_mode,
      owner   => $dnscache::config_file_owner,
    }

  }

  # These settings are needed for the Debian osfamily only

  else {

    # Daemontools run scripts

    file { "${dnscache::dnscache_service_dir}/log/run":
      content => template($dnscache::config_log_run_script_template),
      group   => $dnscache::config_file_group,
      mode    => $dnscache::config_log_run_script_mode,
      owner   => $dnscache::config_file_owner,
    }

    file { "${dnscache::dnscache_service_dir}/env/run":
      content => template($dnscache::config_run_script_template),
      group   => $dnscache::config_file_group,
      mode    => $dnscache::config_run_script_mode,
      owner   => $dnscache::config_file_owner,
    }

    # Environment variables for the dnscache service

    file { "${dnscache::dnscache_service_dir}/env/CACHESIZE":
      content => $dnscache::cachesize,
    }

    file { "${dnscache::dnscache_service_dir}/env/DATALIMIT":
      content => $dnscache::datalimit,
    }

    file { "${dnscache::dnscache_service_dir}/env/IP":
      content => $dnscache::listen_ip,
    }

    file { "${dnscache::dnscache_service_dir}/env/IPSEND":
      content => $dnscache::ipsend,
    }

    file { "${dnscache::dnscache_service_dir}/env/ROOT":
      content => $dnscache::dnscache_root,
    }

    # The default is not to set these environment variables
    # and therefore have no file for them

    file { "${dnscache::dnscache_service_dir}/env/FORWARDONLY":
      ensure  => $dnscache::forwardonlyfile,
      content => $dnscache::forwardonly,
    }

    file { "${dnscache::dnscache_service_dir}/env/HIDETTL":
      ensure  => $dnscache::hidettlfile,
      content => $dnscache::hidettl,
    }

    # Log permissions

    file { '/var/log/dnscache':
      ensure => directory,
      group  => 'adm',
      mode   => '0755',
      owner  => $dnscache::log_account,
    }

  }

  # These settings are needed for any osfamily

  file { "${dnscache::dnscache_root}/ip":
    ensure  => 'directory',
    mode    => '2755',
    purge   => true,
    recurse =>  true,
  }

  file { $dnscache::root_servers:
    content => join($dnscache::root_server_ips, "\n"),
  }


  # dnscache accepts requests from $accept_net sources
  # A service restart is not actually required when files in $dnscache_root
  # are changed, but the resource is placed here for simplicity

  $ip_path = "${dnscache::dnscache_root}/ip/"
  $accept_path = prefix($dnscache::accept_net, $ip_path)

  file { $accept_path:
    ensure => file,
  }
}
