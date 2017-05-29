class people::enverex {
	include projects::all

	#include libreoffice
	include netbeans
	#include geany
	#include thunderbird
	#include chrome::chromium

	include osx::global::disable_autocorrect
        include osx::finder::unhide_library
        include osx::finder::show_hidden_files
        include osx::safari::enable_developer_mode
        osx::dock::hot_corner { 'Top Right':
                action => 'Start Screen Saver'
        }

    package { [
        #'colloquy',
        #'evernote',
        'gimp',
	'autossh',
        'mysqlworkbench',
        #'google-chrome',
        #'reggy',
        'libreoffice',
        'chromium',
        'thunderbird',
        'geany',
        #'stellarium',
	'disk-inventory-x'
    ]: provider => 'brewcask', install_options => ['--appdir=/Applications'] }
}
