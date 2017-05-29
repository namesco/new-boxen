class people::flyingbuddha
{
    # include people::flyingbuddha::apache
    # include people::flyingbuddha::applications
    # include people::flyingbuddha::bin
    # include people::flyingbuddha::cron
    # include people::flyingbuddha::git
    # include people::flyingbuddha::mysql
    # include people::flyingbuddha::osx
    # include people::flyingbuddha::php
    # include people::flyingbuddha::projects
    # include people::flyingbuddha::vim
    # include people::flyingbuddha::zsh

    # file { 'create receipts directory':
    # 	path => "/Users/${::boxen_user}/.puppet-receipts",
    # 	ensure => "directory",
    # }

    require namesco::environment::php
}
