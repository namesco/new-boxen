# Public: specify the global php version for phpenv
#
# Usage:
#
#   class { 'php::global': version => '5.4.10' }
#
class php::global($version = undef) {
  include php::config

  # Get full patch version of PHP
  $patch_version = php_get_patch_version($version)

  # Default to latest version of PHP 5 if not specified
  $php_version = $patch_version ? {
    undef   => 5,
    default => $version
  }

  if $patch_version != 'system' {
    php_require($patch_version)
  }

  file { "${php::config::root}/version":
    ensure  => present,
    owner   => $::boxen_user,
    mode    => '0644',
    content => "${patch_version}\n",
  }
}
