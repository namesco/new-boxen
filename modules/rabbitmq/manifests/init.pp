# Install rabbitmq
#
class rabbitmq(
  $ensure = present,
) {
  include homebrew

  case $ensure {
    present: {

      file { [
        "${boxen::config::homebrewdir}/etc/rabbitmq",
        "${::boxen_home}/config/rabbitmq"
      ]:
        ensure => directory
      }

      file { [
        "${::boxen_home}/log/rabbitmq/",
        "${::boxen_home}/data/rabbitmq/",
      ]:
        ensure => directory,
        owner => $::boxen_user
      }

      file { '/Library/LaunchDaemons/dev.rabbitmq.plist':
        content => template('rabbitmq/dev.rabbitmq.plist.erb'),
        group   => 'wheel',
        notify  => Service['dev.rabbitmq'],
        owner   => 'root'
      }

      file { "${boxen::config::homebrewdir}/etc/rabbitmq/rabbitmq-env.conf":
        content => template('rabbitmq/rabbitmq-env.conf.erb'),
        group   => 'wheel',
        notify  => Service['dev.rabbitmq'],
        owner   => 'root'
      }

      file { "${::boxen_home}/config/rabbitmq/enabled_plugins":
        content => template('rabbitmq/enabled_plugins.erb'),
        group   => 'wheel',
        notify  => Service['dev.rabbitmq'],
        owner   => 'root'
      }

      homebrew::formula { 'rabbitmq':
        before => Package['boxen/brews/rabbitmq'],
      }

      package { 'boxen/brews/rabbitmq':
        ensure => '3.5.1-boxen1'
      }

      service { 'dev.rabbitmq':
        ensure => running
      }
    }

    absent: {
      service { 'dev.rabbitmq':
        ensure => stopped,
      }

      file { '/Library/LaunchDaemons/dev.rabbitmq.plist':
        ensure => absent
      }

      file { "${boxen::config::homebrewdir}/rabbitmq/rabbitmq-env.conf":
        ensure => absent
      }

      file { "${::boxen_home}/config/rabbitmq/enabled_plugins":
        ensure => absent
      }

      package { 'boxen/brews/rabbitmq':
        ensure => absent,
      }

    }

    default: {
      fail('Rabbitmq#ensure must be present or absent!')
    }
  }
}
