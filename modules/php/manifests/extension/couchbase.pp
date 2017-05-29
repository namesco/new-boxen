# Installs a php extension for a specific version of php.
#
# Usage:
#
#     php::extension::couchbase { 'couchbase for 5.4.10':
#       php     => '5.4.10',
#       version => '1.1.2'
#     }
#
define php::extension::couchbase(
  $php,
  $version = '1.1.2'
) {
  require couchbase::lib

  require php::config

  # Get full patch version of PHP
  $patch_php_version = php_get_patch_version($php)

  # Require php version eg. php::5_4_10
  # This will compile, install and set up config dirs if not present
  php_require($patch_php_version)

  $extension = 'couchbase'

  # Final module install path
  $module_path = "${php::config::root}/versions/${patch_php_version}/modules/${extension}.so"

  # Clone the source repository
  # Use ensure_resource, because if you directly use the repository type, it
  # will result in duplicate resource errors when installing the extension in
  # two different PHP versions.
  ensure_resource(
    'repository',
    "${php::config::extensioncachedir}/couchbase",
    {
      source => 'couchbase/php-ext-couchbase'
    }
  )

  # Additional options
  $configure_params = "--with-couchbase=${boxen::config::homebrewdir}/opt/libcouchbase"

  # Build & install the extension
  php_extension { $name:
    provider         => 'git',

    extension        => $extension,
    version          => $version,

    homebrew_path    => $boxen::config::homebrewdir,
    phpenv_root      => $php::config::root,
    php_version      => $patch_php_version,

    cache_dir        => $php::config::extensioncachedir,
    require          => Repository["${php::config::extensioncachedir}/couchbase"],

    configure_params => $configure_params,
  }

  # Add config file once extension is installed

  file { "${php::config::configdir}/${patch_php_version}/conf.d/${extension}.ini":
    content => template('php/extensions/generic.ini.erb'),
    require => Php_extension[$name],
  }

}

