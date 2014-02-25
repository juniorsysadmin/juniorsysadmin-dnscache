# == Class: dnscache::config
#
class dnscache::config inherits dnscache {

  if $dnscache::uses_conf_file {

    file { $dnscache::config_file:
      ensure  => file,
      mode    => $dnscache::config_file_mode,
      owner   => $dnscache::config_file_owner,
      group   => $dnscache::config_file_group,
      content => template($dnscache::config_file_template),
    }

  }

  else {

    file { "${dnscache::dnscache_root}/env/log/run":
      ensure  => file,
      owner   => $dnscache::config_file_owner,
      group   => $dnscache::config_file_group,
      mode    => $dnscache::config_log_run_script_mode,
      content => template($dnscache::config_log_run_script_template),
    }

    file { "${dnscache::dnscache_root}/env/run":
      ensure  => file,
      owner   => $dnscache::config_file_owner,
      group   => $dnscache::config_file_group,
      mode    => $dnscache::config_run_script_mode,
      content => template($dnscache::config_run_script_template),
    }

    file { "${dnscache::dnscache_root}/env/CACHESIZE":
      ensure  => file,
      owner   => $dnscache::env_owner,
      group   => $dnscache::env_group,
      mode    => $dnscache::env_mode,
      content => $dnscache::cachesize,
    }

    file { "${dnscache::dnscache_root}/env/DATALIMIT":
      ensure  => file,
      owner   => $dnscache::env_owner,
      group   => $dnscache::env_group,
      mode    => $dnscache::env_mode,
      content => $dnscache::datalimit,
    }

    file { "${dnscache::dnscache_root}/env/IP":
      ensure  => file,
      owner   => $dnscache::env_owner,
      group   => $dnscache::env_group,
      mode    => $dnscache::env_mode,
      content => $dnscache::listen_ip,
    }

    file { "${dnscache::dnscache_root}/env/IPSEND":
      ensure  => file,
      owner   => $dnscache::env_owner,
      group   => $dnscache::env_group,
      mode    => $dnscache::env_mode,
      content => $dnscache::ipsend,
    }

    file { "${dnscache::dnscache_root}/env/ROOT":
      ensure  => file,
      owner   => $dnscache::env_owner,
      group   => $dnscache::env_group,
      mode    => $dnscache::env_mode,
      content => $dnscache::dnscache_root,
    }

    # Default is not to set these ENV variables
    # and therefore have no file for them

    if $dnscache::forwardonly != nil {

      file { "${dnscache::dnscache_root}/env/FORWARDONLY":
        ensure  => file,
        owner   => $dnscache::env_owner,
        group   => $dnscache::env_group,
        mode    => $dnscache::env_mode,
        content => $dnscache::forwardonly,
      }

    }

    if $dnscache::hidettl != nil {

      file { "${dnscache::dnscache_root}/env/HIDETTL":
        ensure  => file,
        owner   => $dnscache::env_owner,
        group   => $dnscache::env_group,
        mode    => $dnscache::env_mode,
        content => $dnscache::hidettl,
      }

    }

  }

  # dnscache accepts requests from $accept_net sources
  # A service restart is not actually required when files in $dnscache_root
  # are changed, but the resource is placed here for simplicity

  $accept_path = prefix("${dnscache::dnscache_root}/ip/",
    $dnscache::accept_net)

  file { 'accepted_networks':
    ensure  => present,
    path    => $accept_path,
    owner   => $dnscache::env_owner,
    group   => $dnscache::env_group,
    mode    => $dnscache::env_mode
  }
}