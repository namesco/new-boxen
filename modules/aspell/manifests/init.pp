# This is a placeholder class.
class aspell(
  $ensure = present,
) {
  include homebrew

  case $ensure {
    present: {

      homebrew::formula { 'aspell':
        before => Package['boxen/brews/aspell'],
      }

      package { 'boxen/brews/aspell':
        ensure => '0.60.6.1-boxen1'
      }

    }

    absent: {
      package { 'boxen/brews/aspell':
        ensure => absent
      }
    }

    default: {
      fail('Aspell#ensure must be present or absent!')
    }
  }
}