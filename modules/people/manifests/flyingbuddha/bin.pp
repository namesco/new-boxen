class people::flyingbuddha::bin
{
    $bin = "/Users/${::boxen_user}/bin"

    repository { 'setup local bin dir':
        source => 'ssh://git@bitbucket.org/flyingbuddha/bin.git',
        path => $bin,
    }

    # pull additional dependencies into bin
    exec { 'run composer install within ~/bin':
        command => 'bash -c "source ~/.zshrc; composer install"',
        user => $::boxen_user,
        cwd => $bin,
        require => [
            Repository['setup local bin dir'],
            Exec['download-php-composer']
        ],
    }

    file { 'linking svneligible':
        path    => "${bin}/svneligible",
        target  => "${bin}/vendor/flyingbuddha/svntools/svneligible.php",
        ensure  => link,
        require => Exec['run composer install within ~/bin'],
    }

    file { 'linking msgfmt to gt in ~/bin':
        path => "${bin}/gt",
        target => "/opt/boxen/homebrew/bin/msgfmt",
        ensure => link,
        require => [
            Exec['run composer install within ~/bin'],
            Package['gettext']
        ],
    }
}
