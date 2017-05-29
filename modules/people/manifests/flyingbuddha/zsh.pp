class people::flyingbuddha::zsh
{
    $home = "/Users/${::boxen_user}"

    # setup zsh
    repository { 'cloning oh-my-zsh':
        source => 'https://github.com/robbyrussell/oh-my-zsh.git',
        path => "${home}/.oh-my-zsh"
    }

    file { 'create .zshrc file':
        path => "${home}/.zshrc",
        content => template("people/flyingbuddha/zsh/.zshrc"),
        mode => '0600',
        require => Repository['cloning oh-my-zsh'],
    }

    file { 'drop in oh-my-zsh theme':
        path => "${home}/.oh-my-zsh/themes/hike.blinks.zsh-theme",
        content => template("people/flyingbuddha/zsh/hike.blinks.zsh-theme"),
        require => File['create .zshrc file'],
    }

    exec { 'change shell to zsh':
        command => 'chsh -s /bin/zsh',
        unless => 'test "-zsh" != $0',
        user => 'root',
        require => File['drop in oh-my-zsh theme'],
    }
}
