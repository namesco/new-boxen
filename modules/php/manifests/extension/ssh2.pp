# Installs a php extension for a specific version of php.
#
# Usage:
#
#     php::extension::ssh2 { 'ssh2 for 5.4.10':
#       version   => '0.12'
#       php       => '5.4.10',
#     }
#
define php::extension::ssh2(
  $php,
  $version = '0.12'
) {
  require php::config

  # Get full patch version of PHP
  $patch_php_version = php_get_patch_version($php)

  # Require php version eg. php::5_4_10
  # This will compile, install and set up config dirs if not present
  php_require($patch_php_version)

  package { 'libssh2': }

  $extension = 'ssh2'
  $package_name = "ssh2-${version}"
  $url = "http://pecl.php.net/get/ssh2-${version}.tgz"

  # Final module install path
  $module_path = "${php::config::root}/versions/${patch_php_version}/modules/${extension}.so"

  # Additional options
  $configure_params = "--with-ssh2=${boxen::config::homebrewdir}/opt/libssh2"

  php_extension { $name:
    extension        => $extension,
    version          => $version,
    package_name     => $package_name,
    package_url      => $url,
    homebrew_path    => $boxen::config::homebrewdir,
    phpenv_root      => $php::config::root,
    php_version      => $patch_php_version,
    cache_dir        => $php::config::extensioncachedir,
    provider         => pecl,
    configure_params => $configure_params,
    require          => Package['libssh2'],
  }

  # Add config file once extension is installed

  file { "${php::config::configdir}/${patch_php_version}/conf.d/${extension}.ini":
    content => template('php/extensions/generic.ini.erb'),
    require => Php_extension[$name],
  }

}
