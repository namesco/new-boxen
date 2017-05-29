class people::gglendinning {
    exec { "pwd":
    }

	# install apps
	include dropbox
	include chrome
	include netbeans::php
	include sublime_text::v2
	include textwrangler
	include reggy
#	include beanstalk

	# OS X settings
	include osx::global::disable_autocorrect
	include osx::finder::unhide_library
	include osx::finder::show_hidden_files
	include osx::safari::enable_developer_mode
#	include osx::mouse::swipe_between_pages

    # Our projects
	include projects::all

#	homebrew::tap { 'homebrew/dupes': }
	$brewpackages = [
        'tinyproxy',
        'homebrew/dupes/nano',
        'dos2unix',
        'unix2dos'
    ]
	package { $brewpackages: ensure => latest }

    #
    # Homebrew: Cask (GUI) Apps.....
    #
    package {[
        '1password',
        'libreoffice'
    ]:
        provider => 'brewcask',
    }
    package {[
        'autossh',
    ]: }

    # Configure Apache and then restart it.
    file { '/etc/apache2/other/gglendinning.conf':
        content => template("people/gglendinning/apache/gglendinning.conf"),
        group => 'wheel',
        owner => 'root'
    }

}
