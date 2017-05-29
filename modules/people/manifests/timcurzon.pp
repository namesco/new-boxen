class people::timcurzon {

	# ~~~~~~~~~~~~~~~~~~~~
	# Definitions
	# ~~~~~~~~~~~~~~~~~~~~

	$home_dir = "/Users/${::boxen_user}/"

	# ~~~~~~~~~~~~~~~~~~~~
	# OS X
	# ~~~~~~~~~~~~~~~~~~~~

	include osx::global::enable_keyboard_control_access
	include osx::finder::unhide_library
	include osx::global::expand_save_dialog
	include osx::safari::enable_developer_mode
	osx::dock::hot_corner { 'Bottom Right':
		action => 'Start Screen Saver'
	}
	class {'osx::global::natural_mouse_scrolling':
		enabled => false
	}

	# ~~~~~~~~~~~~~~~~~~~~
	# Apps (Puppet)
	# ~~~~~~~~~~~~~~~~~~~~

	include adium
	include chrome
	include dropbox
	include firefox
	include iterm2::stable
	include iterm2::colors::solarized_light
	include iterm2::colors::solarized_dark
	include omnigraffle
	include omnigraffle::pro
	include reggy
	include steam
	include textwrangler
	include thunderbird

	#
	# Apps requiring custom install.....
	#

	# SublimeText
	#include people::timcurzon::sublimetext

	# Vagrant
	class { 'vagrant': }

	# ~~~~~~~~~~~~~~~~~~~~
	# Apps (Homebrew)
	# ~~~~~~~~~~~~~~~~~~~~

	package {[
		'autossh',
		'hardlink-osx',
		'jq',
		'p7zip', 
		'rename',
		'watch',
		'youtube-dl'
	]: }

	#
	# Cask (GUI) Apps.....
	#

	package {[
		'1password',
		'docker',
		'keepassx',
		'kitematic',
		'java',
		'libreoffice',
		'macgdbp',
		'tiddlywiki',
		'seashore',
		'versions',
		'xtrafinder',
	]:
		provider => 'brewcask',
	}

	#
	# Apps requiring custom install.....
	#

	# Log File Navigator
	package { 'lnav':
		ensure => present,
		install_options => [
			'--with-curl',
		]
	}

	# FFmpeg
	package { 'ffmpeg':
		ensure => present,
		install_options => [
			'--with-tools',
		]
	}

	# SourceTree
	package { 'sourcetree':
		ensure => present,
		provider => 'brewcask',
		install_options => [
			'--binarydir=/opt/boxen/homebrew/bin',
		]
	}

	# ~~~~~~~~~~~~~~~~~~~~
	# Dev Environment
	# ~~~~~~~~~~~~~~~~~~~~

	# Update composer to latest version
	exec { 'update composer to latest version':
		command => '/opt/boxen/phpenv/bin/composer selfupdate',
		cwd => $home_dir,
		require => Class['php::composer'],
	}

	# Install global Composer utilities
	file { 'create global composer config':
		path => "${home_dir}/.composer/composer.json",
		ensure => present,
		content => template('people/timcurzon/composer.json.erb'),
		require => Class['php::composer'],
	}
	exec { 'update global composer packages':
		command => '/opt/boxen/phpenv/bin/composer global update',
		cwd => $home_dir,
		require => File['create global composer config'],
	}

	# Switch active xcode to xcode app (as opposed to cmdline toolset)
	exec { "select xcode app":
		command => 'xcode-select --switch /Applications/Xcode.app/Contents/Developer', 
		onlyif => 'xcode-select --print-path | grep -v /Applications/Xcode.app/Contents/Developer', 
		user => 'root'
	}

	# ~~~~~~~~~~~~~~~~~~~~
	# Projects
	# ~~~~~~~~~~~~~~~~~~~~

	# Checkout and set up npt related dev projects
	include projects::npt
}
