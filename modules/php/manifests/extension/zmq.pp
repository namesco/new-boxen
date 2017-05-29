# Installs a php extension for a specific version of php.
#
# Usage:
#
#     php::extension::zmq { 'zmq for 5.4.10':
#       php     => '5.4.10',
#       version => '1.0.5'
#     }
#
define php::extension::zmq(
  $php,
  $version = '1.0.5'
) {
  require zeromq

  require php::config

  # Get full patch version of PHP
  $patch_php_version = php_get_patch_version($php)

  # Require php version eg. php::5_4_10
  # This will compile, install and set up config dirs if not present
  php_require($patch_php_version)

  $extension = 'zmq'

  # Final module install path
  $module_path = "${php::config::root}/versions/${patch_php_version}/modules/${extension}.so"

  # Clone the source repository
  # Use ensure_resource, because if you directly use the repository type, it
  # will result in duplicate resource errors when installing the extension in
  # two different PHP versions.
  ensure_resource(
    'repository',
    "${php::config::extensioncachedir}/zmq",
    {
      source => 'mkoppanen/php-zmq'
    }
  )

  # Build & install the extension
  php_extension { $name:
    provider       => 'git',

    extension      => $extension,
    version        => $version,

    homebrew_path  => $boxen::config::homebrewdir,
    phpenv_root    => $php::config::root,
    php_version    => $patch_php_version,

    cache_dir      => $php::config::extensioncachedir,
    require        => Repository["${php::config::extensioncachedir}/zmq"],
  }

  # Add config file once extension is installed

  file { "${php::config::configdir}/${patch_php_version}/conf.d/${extension}.ini":
    content => template('php/extensions/generic.ini.erb'),
    require => Php_extension[$name],
  }

}
