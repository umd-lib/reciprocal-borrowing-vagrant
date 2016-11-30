Package {
  allow_virtual => false,
}

package { 'httpd':
  ensure => present,
}
package { 'mod_ssl':
  ensure => present,
}
package { 'openssl':
  ensure => present,
}
package { 'git':
  ensure => present,
}
package { 'iptables-services':
  ensure => present,
}
package { 'epel-release':
  ensure => present,
}
package { 'nodejs':
  ensure  => present,
  require => Package['epel-release'],
}
package { 'npm':
  ensure => present,
  require => Package['epel-release'],
}
package { 'libcurl-devel':
  ensure => present,
}
package { 'openssl-devel':
  ensure => present,
}
package { 'boost-devel':
  ensure => present,
}
package { 'httpd-devel':
  ensure => present,
}

file { '/apps/borrow':
  ensure => directory,
  owner  => 'vagrant',
  group  => 'vagrant',
}
