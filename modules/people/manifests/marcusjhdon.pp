class people::marcusjhdon {

	$home_dir = "/Users/${::boxen_user}/"

	# install apps
	include netbeans::php
	include textwrangler

	package { [
		'google-chrome',
		'firefox',
		'filezilla',
		'slack'
	]:
		provider => 'brewcask',
		install_options => ['--appdir=/Applications'],
		require => File['/usr/local/bin']
	}

	package { 'netbeans-8.1':
		provider => 'pkgdmg',
		source   => 'http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-macosx.dmg',
	}
	
	osx::dock::hot_corner { 'Bottom Left':
		action => 'Start Screen Saver'
	}

	include projects::all

}
