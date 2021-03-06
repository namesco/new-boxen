# Installs the pecl_http extension for a specific version of php.
#
# Usage:
#
#     php::extension::pecl_http { 'http for 5.4.10':
#       php     => '5.4.10',
#       version => '1.7.5'
#     }
#
define php::extension::pecl_http(
  $php,
  $version = '1.7.5'
) {
  include boxen::config

  require php::config

  # Get full patch version of PHP
  $patch_php_version = php_get_patch_version($php)

  # Require php version eg. php::5_4_10
  # This will compile, install and set up config dirs if not present
  php_require($patch_php_version)

  $extension = 'pecl_http'
  $package_name = "pecl_http-${version}"
  $url = "http://pecl.php.net/get/pecl_http-${version}.tgz"

  # Final module name & install path
  $compiled_name = 'http.so'
  $module_path = "${php::config::root}/versions/${patch_php_version}/modules/${compiled_name}"

  php_extension { $name:
    extension        => $extension,
    version          => $version,
    package_name     => $package_name,
    package_url      => $url,
    homebrew_path    => $boxen::config::homebrewdir,
    phpenv_root      => $php::config::root,
    php_version      => $patch_php_version,
    cache_dir        => $php::config::extensioncachedir,
    compiled_name    => $compiled_name,
  }

  # Add config file once extension is installed

  file { "${php::config::configdir}/${patch_php_version}/conf.d/${extension}.ini":
    content => template('php/extensions/generic.ini.erb'),
    require => Php_extension[$name],
  }

}
