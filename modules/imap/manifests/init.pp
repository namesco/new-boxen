# This is a placeholder class.
class imap(
  $ensure = present,
) {
  include homebrew

  case $ensure {
    present: {

      homebrew::formula { 'imap':
        before => Package['boxen/brews/imap'],
      }

      package { 'boxen/brews/imap':
        ensure => 'imap-2007f-boxen1'
      }

    }

    absent: {
      package { 'boxen/brews/imap':
        ensure => absent
      }
    }

    default: {
      fail('Imap#ensure must be present or absent!')
    }
  }
}
