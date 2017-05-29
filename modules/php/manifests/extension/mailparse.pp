# Installs a php extension for a specific version of php.
#
# Usage:
#
#     php::extension::mailparse { 'mailparse for 5.4.10':
#       php     => '5.4.10',
#       version => '1.0.6'
#     }
#
define php::extension::mailparse(
  $php,
  $version = '2.1.6'
) {
  include boxen::config

  require php::config

  # Get full patch version of PHP
  $patch_php_version = php_get_patch_version($php)

  # Require php version eg. php::5_4_10
  # This will compile, install and set up config dirs if not present
  php_require($patch_php_version)

  $extension = 'mailparse'
  $package_name = "mailparse-${version}"
  $url = "http://pecl.php.net/get/mailparse-${version}.tgz"

  # Final module install path
  $module_path = "${php::config::root}/versions/${php}/modules/${extension}.so"

  # Additional options
  $configure_params = ''

  php_extension { $name:
    extension        => $extension,
    version          => $version,
    package_name     => $package_name,
    package_url      => $url,
    homebrew_path    => $boxen::config::homebrewdir,
    phpenv_root      => $php::config::root,
    php_version      => $php,
    cache_dir        => $php::config::extensioncachedir,
    configure_params => $configure_params,
  }

  # Add config file once extension is installed

  file { "${php::config::configdir}/${php}/conf.d/${extension}.ini":
    content => template('php/extensions/generic.ini.erb'),
    require => Php_extension[$name],
  }

}
