class people::flyingbuddha::osx
{
	$home = "/Users/${::boxen_user}"
    $sequelproDataDir = "${home}/Library/Application Support/Sequel Pro/Data/"

    include osx::finder::unhide_library
    include osx::global::disable_autocorrect
    include osx::global::expand_save_dialog
    include osx::global::tap_to_click
    include osx::no_network_dsstores
    include osx::safari::enable_developer_mode
    include osx::software_update

    class {'osx::global::natural_mouse_scrolling':
        enabled => false
    }

    class {'osx::dock::hot_corners':
        top_right => 'Start Screen Saver',
    }

    file { 'copy terminal colors to /tmp':
    	path => "/tmp/solarized.terminal",
        content => template("people/flyingbuddha/osx/solarized.terminal"),
    }

    exec { 'launch solarized.terminal to fix state':
    	command => "open /tmp/solarized.terminal",
    	require => File['copy terminal colors to /tmp'],
    	creates => "${home}/.puppet-receipts/osx-solarized-terminal-installed",
    }

    file { 'create receipt of solarized.terminal process':
    	path => "${home}/.puppet-receipts/osx-solarized-terminal-installed",
    	content => generate('/bin/date', '+%Y%d%m_%H:%M:%S'),
    	require => File['copy terminal colors to /tmp'],
    }


    repository { 'checkout namesco-configs':
        source => 'git@bitbucket.org:flyingbuddha/namesco-configs.git',
        path => "${home}/namesco-configs",
    }

    repository { 'checkout namesco-queries':
        source => 'git@bitbucket.org:flyingbuddha/namesco-queries.git',
        path => "${home}/namesco-queries",
    }

    exec { 'make sequelpro data dir':
        command => "mkdir -p ${sequelproDataDir}",
        creates => $sequelproDataDir,
        require => Repository['checkout namesco-queries'],
    }

    file { 'copy sequel pro favourites for db connectivity':
        path => "${sequelproDataDir}/Favorites.plist",
        source => "${home}/namesco-queries/Favorites.plist",
        require => [
            Repository['checkout namesco-queries'],
            Exec['make sequelpro data dir'],
        ],
    }

    exec { '[!] Copy ssh keys from 1password to ~/.ssh':
        command => "open ${home}/.ssh",
        creates => "${home}/.ssh/dev_root",
    }


    file { 'write nfs into master mounter':
        path => '/etc/auto_master',
        content => template('people/flyingbuddha/osx/auto_master'),
        owner => 'root',
        group => 'wheel',
        mode => '0644',
    }

    file { 'write nfs automounter':
        path => '/etc/auto_nfs',
        content => template('people/flyingbuddha/osx/auto_nfs'),
        owner => 'root',
        group => 'wheel',
        mode => '0644',
        require => File['write nfs into master mounter'],
    }

    exec { 'trigger automount':
        command => 'automount -cv',
        require => File['write nfs automounter'],
    }
}
