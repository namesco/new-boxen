class people::timcurzon::sublimetext
{
	$settings_dir = "/Users/${::boxen_user}/Library/Application Support/Sublime Text 3"

	# Install SublimeText 3
	include sublime_text

	# Install Package Control properly
	exec { 'Install SublimeText Package Control properly':
		command => "curl -L https://packagecontrol.io/Package%20Control.sublime-package > \"${settings_dir}/Installed Packages/Package Control.sublime-package\"",
		require => Class['sublime_text'],
		creates => "${settings_dir}/Installed Packages/Package Control.sublime-package",
	}

	# Remove any Package Control instance from Packages
	exec { 'Remove SublimeText Package Control from Packages':
		command => "rm -rf \"${settings_dir}/Packages/Package Control/\"",
		require => Package['Sublime Text'],
	}
	
	# Install packages
	sublime_text::package { 'Modific':
		source => 'gornostal/Modific'
	}
	sublime_text::package { 'SidebarEnhancements':
		source => 'titoBouzout/SideBarEnhancements'
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
	sublime_text::package { 'SublimeLinter-jshint':
		source => 'SublimeLinter/SublimeLinter-jshint'
	}
	sublime_text::package { 'SublimeLinter-phpcs':
		source => 'SublimeLinter/SublimeLinter-phpcs'
	}
	sublime_text::package { 'Xdebug':
		source => 'martomo/SublimeTextXdebug'
	}
	sublime_text::package { 'JavaScript Ultimate':
		source => 'JoshuaWise/javascript-ultimate'
	}
	sublime_text::package { 'Sass':
		source => 'nathos/sass-textmate-bundle'
	}

	# Install settings
	file { "${settings_dir}/Packages/User/":
		source => 'puppet:///modules/people/timcurzon/sublimetext/',
		recurse => true,
		require => Package['Sublime Text'],
	}
}
