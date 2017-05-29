class people::lesrowley {

	$home_dir = "/Users/${::boxen_user}/"

	# install apps
	include netbeans::php
	include sublime_text

	sublime_text::package { 'Xdebug':
		source => 'martomo/SublimeTextXdebug'
	}
	sublime_text::package { 'SublimeCodeIntel':
		source => 'SublimeCodeIntel/SublimeCodeIntel'
	}
	sublime_text::package { 'SublimeLinter':
		source => 'SublimeLinter/SublimeLinter3'
	}
	sublime_text::package { 'SublimeLinter-php':
		source => 'SublimeLinter/SublimeLinter-php'
	}
	sublime_text::package { 'SublimeLinter-phpcs':
		source => 'SublimeLinter/SublimeLinter-phpcs'
	}
	sublime_text::package { 'Modific':
		source => 'gornostal/Modific'
	}

	file { "${home_dir}Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings":
        source => 'puppet:///modules/people/lrowley/User-Preferences.sublime-settings',
        require => Class['sublime_text'],
    }

    file { "${home_dir}Library/Application Support/Sublime Text 3/Packages/User/Modific.sublime-settings":
    	source => 'puppet:///modules/people/lrowley/Modific.sublime-settings',
        require => Class['sublime_text'],
    }

	package { [
		'dropbox',
		'flux',
		'reggy',
		'google-chrome',
		'openoffice',
		'firefox',
		'thunderbird',
		'versions'
	]: provider => 'brewcask', install_options => ['--appdir=/Applications'] }

	# OS X settings
	include osx::global::disable_autocorrect
	include osx::finder::unhide_library
	include osx::finder::show_hidden_files
	include osx::safari::enable_developer_mode
	class { 'osx::mouse::button_mode':
	  mode => 2
	}
	osx::dock::hot_corner { 'Top Left':
		action => 'Start Screen Saver'
	}
	include osx::mouse::swipe_between_pages

	case $::macaddress {

		# Work MacBook Air
		'7c:c3:a1:89:99:dc': {

			# Ensure that the .ssh directory exists
			file { "${home_dir}.ssh":
				ensure => directory
			}

			# Symlink the ssh config in place. Force because a file might already exist.
		#	file { "${home_dir}.ssh/config":
		#		ensure => link,
		#		force => true,
		#		target => "${home_dir}src/dotfiles/ssh/config",
		#		require => [
		#			File["${home_dir}.ssh"],
		#			Exec['checkout dotfile']
		#		]
		#	}
			include projects::all

		}
		default: {
			notify { "$::hostname Wha?": }
			notify { "$::macaddress": }
		}
	}

}
