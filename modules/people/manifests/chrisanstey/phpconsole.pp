class people::chrisanstey::phpconsole
{
    $phpconsole_repo = "https://github.com/Seldaek/php-console.git"
    $phpconsole_home = "/Users/${::boxen_user}/Sites/dev/tools/phpconsole/web"

    # Checkout PHP-console from GitHub
    repository { 'checkout phpconsole':
        source => "${phpconsole_repo}",
        path => "${phpconsole_home}",
    }

    # Install dependencies via composer
    exec { 'composer install for phpconsole':
        command => "${::boxen_home}/phpenv/bin/composer selfupdate && ${::boxen_home}/phpenv/bin/composer install",
        cwd => $phpconsole_home,
        creates => "${phpconsole_home}/vendor",
        require => Repository['checkout phpconsole'],
    }

    # copy config to expected filename (secures app by limiting to localhost).
    file { "${phpconsole_home}/config.php":
        source => "${phpconsole_home}/config.php.dist",
        require => Repository['checkout phpconsole'],
    }
}
