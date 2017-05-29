class people::contradev {


#	package { [
#		'chromium',
#		'gimp',
#		'thunderbird',
#		'geany',
#		'stellarium',
#		'disk-inventory-x',
#		'libreoffice',
#		'mysqlworkbench',
#		'1password'
#	]: provider => 'brewcask',
#		install_options => ['--appdir=/Applications'],
#		require => File['/usr/local/bin']
#	}

	# OS X settings
#	include osx::global::disable_autocorrect
#	include osx::finder::unhide_library
	#include osx::finder::show_hidden_files
#	include osx::safari::enable_developer_mode
#	osx::dock::hot_corner { 'Top Left':
#		action => 'Start Screen Saver'
#	}


#	include projects::all
#	include netbeans::php
#	include sublime_text
#        sublime_text::package { 'Xdebug':
#                source => 'martomo/SublimeTextXdebug'
#        }
#        sublime_text::package { 'SublimeCodeIntel':
#                source => 'SublimeCodeIntel/SublimeCodeIntel'
#        }
#        sublime_text::package { 'SublimeLinter':
#                source => 'SublimeLinter/SublimeLinter3'
#        }
#        sublime_text::package { 'SublimeLinter-php':
#                source => 'SublimeLinter/SublimeLinter-php'
#	}

}
