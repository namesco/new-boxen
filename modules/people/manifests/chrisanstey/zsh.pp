class people::chrisanstey::zsh
{
    $home = "/Users/${::boxen_user}"

    # setup zsh
    repository { 'cloning oh-my-zsh':
        source => 'https://github.com/robbyrussell/oh-my-zsh.git',
        path => "${home}/.oh-my-zsh"
    }

    file { 'create .zshrc file':
        path => "${home}/.zshrc",
        content => template("/opt/boxen/repo/modules/people/templates/${::boxen_user}/zsh/.zshrc"),
        mode => '0600',
        require => Repository['cloning oh-my-zsh'],
    }

    exec { 'change shell to zsh':
        command => 'chsh -s /bin/zsh',
        unless => 'test "-zsh" != $0',
        require => File['create .zshrc file'],
    }
}
