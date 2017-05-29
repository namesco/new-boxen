class people::flyingbuddha::applications
{
    include people::flyingbuddha::applications::sublime
    include people::flyingbuddha::applications::sendmail

    homebrew::tap { 'caskroom/homebrew-versions': }

    package {[
        'colordiff',
        'colorsvn',
        'couchdb',
        'cracklib',
        'cracklib-words',
        'ejabberd',
        'htop-osx',
        'node',
        'phantomjs',
        'rbenv',
        'siege',
        'subversion',
        'terminal-notifier',
    ]:}

    # install xquartz first as several apps depend on it
    package { 'xquartz':
        provider => 'brewcask',
        install_options => ['--appdir=/Applications'],
    }

    # install apps through brew-cask
    package {[
		'1password',
        'adobe-creative-cloud',
        'diffmerge',
        'dropbox',
        'firefoxdeveloperedition',
        'gitx',
        'google-chrome',
        'handbrake',
        'hipchat',
        'macgdbp',
        'microsoft-office',
        'mysqlworkbench',
        'opera',
        'reggy',
        'slack',
        'spotify',
        'steam',
        'vagrant',
        'virtualbox',
        'wireshark',
    ]:
        provider => 'brewcask',
        install_options => ['--appdir=/Applications'],
        require => Package['xquartz'],
    }
}
