class people::flyingbuddha::php
{
    require namesco::environment::php

    $home = "/Users/${::boxen_user}"
    $extensions = "/opt/boxen/config/php/${namesco::environment::php::php_version}/conf.d"

    # php::extension::intl { "intl for ${namesco::environment::php::php_version}":
    #    php => $namesco::apps::mac::php_version
    # }

    # php::extension::ssh2 { "ssh2 for ${namesco::environment::php::php_version}":
    #    php => $namesco::apps::mac::php_version
    # }

    # @todo: php extensions: ioncubeloader, pspell

    file { 'copy xdebug.ini':
        path => "${extensions}/xdebug.ini.mine",
        content => template('people/flyingbuddha/php/xdebug.ini'),
    }

    exec { 'move my xdebug.ini in place':
        command => "mv ${extensions}/xdebug.ini.mine ${extensions}/xdebug.ini",
        require => [
            File['copy xdebug.ini'],
            File["${extensions}/xdebug.ini"],
        ],
    }

    file { 'copy hike.ini':
        path => "${extensions}/hike.ini",
        content => template('people/flyingbuddha/php/hike.ini'),
    }

    repository { 'checkout php-ext':
        source => 'https://github.com/flyingbuddha/php-ext.git',
        path => "${home}/bin/php-ext",
    }
}