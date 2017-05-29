class people::jackw {

	# Setup OSX
	include osx::global::enable_keyboard_control_access
	include osx::global::expand_save_dialog
	include osx::global::key_repeat_delay
	include osx::global::key_repeat_rate
	include osx::global::expand_save_dialog
	include osx::dock::autohide
	include osx::finder::show_mounted_servers_on_desktop
	include osx::finder::unhide_library
	include osx::safari::enable_developer_mode

	class {'osx::global::natural_mouse_scrolling':
		enabled => false
	}

	class {'osx::dock::hot_corners':
		top_right => 'Start Screen Saver',
	}

	$home_dir = "/Users/${::boxen_user}"
	

	# Install Sublime Text 3 prior to setting up symlinks
	homebrew::tap { 'caskroom/homebrew-versions': }

	package {[
		'dropbox',
		'sublime-text3',
	]:
		provider => 'brewcask',
		install_options => ['--appdir=/Applications']
	}
 
	# Setup Sublime Text 3 Package symlinks.
	file { "${home_dir}/Library/Application Support/Sublime Text 3/Installed Packages":
		ensure => link,
		force => true,
		target => "${home_dir}/Dropbox/Apps/Sublime Text 3/Installed Packages",
		require => [
			Package['dropbox'],
			Package['sublime-text3']
		]
	}

        file { "${home_dir}/Library/Application Support/Sublime Text 3/Packages":
                ensure => link,
                force => true,
                target => "${home_dir}/Dropbox/Apps/Sublime Text 3/Packages",
                require => [
                        Package['dropbox'],
                        Package['sublime-text3']
                ]
        }

	# install binaries
	package {[
		'couchdb',
		'phantomjs',
	]: }

	# install apps through brew-cask
	package {[
		'1password',
		'adobe-creative-cloud',
		'alfred',
		'codekit',
		'cornerstone',
		'filezilla',
		'firefox',
		'google-chrome',
		'google-chrome-canary',
		'handbrake',
		'miro-video-converter',
		'opera',
		'parallels10',
		'sourcetree',
		'spotify',
		'transmit',
	]:
		provider => 'brewcask',
		install_options => ['--appdir=/Applications'] 
	}

}
