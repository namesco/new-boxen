class people::lightstream {

	# install apps
	include netbeans::php
	include firefox
	include thunderbird
	include projects::all

    package {[
        'autossh',
        'boot2docker',
        'docker',
        'docker-machine',
    ]: }

        package { [
                'chromium',
                'gimp',
                'geany',
		'libreoffice',
		'1password',
        ]: provider => 'brewcask', install_options => ['--appdir=/Applications'] }

	# OS X settings
	include osx::global::disable_autocorrect
	include osx::finder::unhide_library
	include osx::finder::show_hidden_files
	include osx::safari::enable_developer_mode
	class { 'osx::sound::interface_sound_effects':
	  enable => false
	}
}
