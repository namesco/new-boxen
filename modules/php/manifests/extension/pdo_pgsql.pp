# Installs the pdo_pgsql extension for a specific version of php.
#
# Usage:
#
#     php::extension::pdo_pgsql { 'pdo_pgsql for 5.4.10':
#       php       => '5.4.10',
#     }
#
define php::extension::pdo_pgsql(
  $php,
) {
  require php::config

  # Get full patch version of PHP
  $patch_php_version = php_get_patch_version($php)

  # Require php version eg. php::5_4_10
  # This will compile, install and set up config dirs if not present
  php_require($patch_php_version)

  $extension = 'pdo_pgsql'

  # Final module install path
  $module_path = "${php::config::root}/versions/${patch_php_version}/modules/${extension}.so"

  # Additional options
  $configure_params = "--with-pdo-pgsql=${boxen::config::homebrewdir}/opt/postgresql"

  php_extension { $name:
    provider         => php_source,

    extension        => $extension,

    homebrew_path    => $boxen::config::homebrewdir,
    phpenv_root      => $php::config::root,
    php_version      => $patch_php_version,

    configure_params => $configure_params,
  }

  # Add config file once extension is installed

  file { "${php::config::configdir}/${patch_php_version}/conf.d/${extension}.ini":
    content => template('php/extensions/generic.ini.erb'),
    require => Php_extension[$name],
  }

}
