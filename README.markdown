####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with dnscache](#setup)
    * [What dnscache affects](#what-dnscache-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dnscache](#beginning-with-dnscache)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The dnscache module installs, configures and manages the dnscache service.

##Module Description

The dnscache module handles installing, configuring and running dnscache on
Fedora, CentOS/Redhat and Debian/Ubuntu.

##Setup

###What dnscache affects

* dnscache-run / ndjbdns package
* ndjbdns configuration file
* dnscache ENVIRONMENT files
* dnscache service

WARNING: Debian/Ubuntu modifies /etc/resolv.conf to point to 127.0.0.1 which
could pose a problem with DNS if dnscache is not started after the package
is installed.

###Beginning with dnscache

`include '::dnscache'` sets dnscache to listen on $::ipaddress and accept DNS
queries coming from 127.0.0.1. If you want to dnscache to accept DNS queries
from say a local network, then:

```puppet
class { '::dnscache':
  accept_ip => [ '127.0.0.1', '192.168.1' ],
}
```

##Usage

All interaction with the dnscache module can be done through the main dnscache
class. This means you can simply toggle the options in `::dnscache` to have
full functionality of the module.

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here. 

##Reference

###Classes

####Public Classes

* dnscache: Main class, includes all other classes.

####Private Classes

* dnscache::install: Handles the packages.
* dnscache::config: Handles the ndjbdns configuration file and the dnscache
  environment variables
* dnscache::services: Handles the service.

###Parameters

The following parameters are available in the dnscache module:

####`accept_net`

An array listing of IP addresses or subnets that are written out to
$dnscache_root/ip/ as separate files. The dnscache daemon accepts DNS requests
from these IP/subnet addresses. Defaults to ['127.0.0.1']

####`cachesize`

CACHESIZE dnscache environment variable. Defaults to distribution default
value.

####`config_file`

Location of the dnscache.conf file used by ndjbdns. Defaults to
/etc/ndjbdns/dnscache.conf

####`config_file_group`

Group for the dnscache.conf file used by the ndjbdns package. Defaults to 0.

####`config_file_mode`

File permissions for /etc/ndjbdns/dnscache.conf. Defaults to 0644.

####`config_file_owner`

Owner of /etc/ndjbdns/dnscache.conf. Defaults to 0.

####`config_file_template`

Location of the template that modifies /etc/ndjbdns/dnscache.conf. Defaults to
dnscache/dnscache.conf.erb

####`config_log_run_script_mode`

File permissions for the ${dnscache_root}/log/run script that invokes
dnscache. Defaults to 0755.

####`config_run_script_template`

Location of the template that modifies the original script in
${dnscache_root}/env/run Defraults to nscache/dnscache-run.erb

####`datalimit`

DATALIMIT dnscache environment variable. Defaults to distribution default
value.

####`debug_level`

DEBUG_LEVEL dnscache environment variable.

####`dnscache_account`

Account under which dnscache is invoked via ${dnscache_root/env/run
Defaults to Gdnscache.

####`dnscache_root`

ROOT dnscache environment variable. Defaults to /etc/sv/dnscache/root on
osfamily Debian or /etc/ndjbdns on osfamily Redhat

####`env_group`

Group for dnscache environment files placed in ${dnscache_root}/env when on
osfamily Debian and also $accept_net IPs placed in ${dnscache_root}/ip/
osfamily: Debian and Redhat. Defaults to 0.

####`env_mode`

File permissions for dnscache environment files placed in ${dnscache_root}/env
when on osfamily Debian and also $accept_net IPs placed in ${dnscache_root}/ip/
osfamily: Debian and Redhat. Defaults to 0644.

####`env_owner`

Owner of dnscache environment files placed in ${dnscache_root}/env when on
osfamily Debian and also $accept_net IPs placed in ${dnscache_root}/ip/
osfamily: Debian and Redhat. Defaults to 0.

####`forwardonly`

FORWARDONLY dnscache environment variable. Defaults to undef.

####`gid`

gid that will be acquired by dnscache. Defaults to 2.

####`hidettl`

HIDETTL dnscache environment variable. Defaults to undef.

####`ipsend`

IPSEND dnscache environment variable. Defaults to 0.0.0.0

####`listen_ip`

IP dnscache environment variable. Defaults to $::ipaddress

####`log_account`

Account that will be used to run multilog for dnscache. Must have a UID and
GID. Defaults to Gdnslog.

####`mergequeries`

MERGEQUERIES dnscache environment variable. Defaults to 1.

####`package_ensure`

Sets the dnscache package to be installed. Can be set to 'present', 'latest',
or a specific version. Defaults to present.

####`package_name`

Determines the name of the package to install. Defaults to dnscache-run on
osfamily Debian or ndjbdns on osfamily Redhat.

####`service_enable`

Determines if the service should be enabled at boot. Defaults to true.

####`service_ensure`

Determines if the service should be running or not. Defaults to running.

####`service_name`

Selects the name of the dnscache service for Puppet to manage. Defaults to
dnscache.

####`uid`

uid that will be acquired by dnscache. Defaults to 2.

####`use_dbndns`

Unused and reserved for future use should we want to use the Debian dbndns
package rather than dnscache-run


##Limitations

This module has been build on and tested against Puppet 2.7 and higher.

This module has been tested on:

* Arch Linux
* CentOS 5/6
* Debian 7/8
* Fedora 19/20
* Ubuntu 14.04

##Development

Patches are welcome.
