# Installs the PECL intl extension for a specific version of php.
#
# Usage:
#
#     php::extension::intl { 'intl for 5.4.10':
#       php     => '5.4.10',
#       version => '2.0.1'
#     }
#
define php::extension::intl(
  $php,
  $version = '2.0.1'
) {
  require php::config

  # Get full patch version of PHP
  $patch_php_version = php_get_patch_version($php)

  # Require php version eg. php::5_4_10
  # This will compile, install and set up config dirs if not present
  php_require($patch_php_version)

  $extension = 'intl'
  $package_name = "intl-${version}"
  $url = "http://pecl.php.net/get/intl-${version}.tgz"

  # Final module install path
  $module_path = "${php::config::root}/versions/${patch_php_version}/modules/${extension}.so"

  # Additional options
  $configure_params = "--with-icu-dir=${boxen::config::homebrewdir}/opt/icu4c"

  php_extension { $name:
    extension        => $extension,
    version          => $version,
    package_name     => $package_name,
    package_url      => $url,
    homebrew_path    => $boxen::config::homebrewdir,
    phpenv_root      => $php::config::root,
    php_version      => $patch_php_version,
    cache_dir        => $php::config::extensioncachedir,
    configure_params => $configure_params,
  }

  # Add config file once extension is installed

  file { "${php::config::configdir}/${patch_php_version}/conf.d/${extension}.ini":
    content => template('php/extensions/generic.ini.erb'),
    require => Php_extension[$name],
  }

}
