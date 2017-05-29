class people::chrisanstey {

    $home_dir = "/Users/${::boxen_user}/"

    # install apps
    include firefox
    include thunderbird
    include dropbox
    include flux
    include iterm2::stable
    include iterm2::colors::solarized_light
    include iterm2::colors::solarized_dark
    include netbeans::php
    include textwrangler
    include reggy
    include keepassx
    include sublime_text

    sublime_text::package { 'SublimeCodeIntel':
            source => 'SublimeCodeIntel/SublimeCodeIntel'
    }
    sublime_text::package { 'SublimeLinter':
            source => 'SublimeLinter/SublimeLinter3'
    }
    sublime_text::package { 'SublimeLinter-php':
            source => 'SublimeLinter/SublimeLinter-php'
    }

    # Vagrant
    class { 'vagrant': }

    package {[
        'autossh',
        'boot2docker',
        'docker',
        'docker-machine',
    ]: }

    package { [
        'colloquy',
        'disk-inventory-x',
        'evernote',
        'gimp',
        'mysqlworkbench',
        'google-chrome',
        'reggy',
        'libreoffice'
    ]: provider => 'brewcask', install_options => ['--appdir=/Applications'] }

    # OS X settings
    include osx::global::disable_autocorrect
    include osx::finder::unhide_library
    include osx::finder::show_hidden_files
    include osx::safari::enable_developer_mode
    osx::dock::hot_corner { 'Top Left':
            action => 'Start Screen Saver'
    }
    include osx::mouse::swipe_between_pages

	include people::chrisanstey::zsh

    # Checkout my dotfiles
    exec { 'checkout dotfile':
        command => "svn co http://svn.server.dev/svn/dotfiles/canstey /Users/${::boxen_user}/src/dotfiles",
        creates => "${home_dir}src/dotfiles"
    }
    # Checkout my dotfiles
    repository { "${home_dir}/src/dotfiles":
        source   => 'https://canstey@stash.server.dev/scm/~canstey/dotfiles.git',
    }

    # Update my dotfiles
    exec { 'update dotfile':
        command => "git pull /Users/${::boxen_user}/src/dotfiles",
    }

    # Ensure that the .ssh directory exists
    file { "${home_dir}.ssh":
        ensure => directory
    }

    # Symlink the ssh config in place. Force because a file might already exist.
    file { "${home_dir}.ssh/config":
        ensure => link,
        force => true,
        target => "${home_dir}src/dotfiles/canstey/ssh/config",
        require => [
            File["${home_dir}.ssh"],
            Repository["${home_dir}/src/dotfiles"]
        ]
    }

    # Symlink the aliases in place. Force because a file might already exist.
    file { "${home_dir}.aliases":
        ensure => link,
        force => true,
        target => "${home_dir}src/dotfiles/aliases",
        require => [
            Exec['checkout dotfile']
        ]
    }

    # include checkout and set up of all dev projects
    include projects::all

    include people::chrisanstey::phpconsole

}

