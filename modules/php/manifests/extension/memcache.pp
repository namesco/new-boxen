# Installs a php extension for a specific version of php.
#
# Usage:
#
#     php::extension::memcache { 'memcache for 5.4.10':
#       version   => '2.2.7'
#       php       => '5.4.10',
#     }
#
define php::extension::memcache(
  $php,
  $version = '2.2.7'
) {
  include boxen::config

  require php::config

  # Get full patch version of PHP
  $patch_php_version = php_get_patch_version($php)

  # Require php version eg. php::5_4_10
  # This will compile, install and set up config dirs if not present
  php_require($patch_php_version)


  $extension = 'memcache'
  $package_name = "memcache-${version}"
  $url = "http://pecl.php.net/get/memcache-${version}.tgz"

  # Final module install path
  $module_path = "${php::config::root}/versions/${patch_php_version}/modules/${extension}.so"

  php_extension { $name:
    extension        => $extension,
    version          => $version,
    package_name     => $package_name,
    package_url      => $url,
    homebrew_path    => $boxen::config::homebrewdir,
    phpenv_root      => $php::config::root,
    php_version      => $patch_php_version,
    cache_dir        => $php::config::extensioncachedir,
  }

  # Add config file once extension is installed

  file { "${php::config::configdir}/${patch_php_version}/conf.d/${extension}.ini":
    content => template('php/extensions/generic.ini.erb'),
    require => Php_extension[$name],
  }

}
