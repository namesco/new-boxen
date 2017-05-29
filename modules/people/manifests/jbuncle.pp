class people::jbuncle {
	require namesco::environment::php

	$home_dir = "/Users/${::boxen_user}/"
	include graphviz

	# install apps
	# include sublime_text
	# include textwrangler
	include chrome::canary
	include omnigraffle
	include omnigraffle::pro

	#sublime_text::package { 'Xdebug':
	#	source => 'martomo/SublimeTextXdebug'
	#}
	#sublime_text::package { 'SublimeCodeIntel':
	#	source => 'SublimeCodeIntel/SublimeCodeIntel'
	#}
	#sublime_text::package { 'SublimeLinter':
	#	source => 'SublimeLinter/SublimeLinter3'
	#}
	#sublime_text::package { 'SublimeLinter-php':
	#	source => 'SublimeLinter/SublimeLinter-php'
	#}

	package {[
	    '1password',
		'atom',
		#'dockertoolbox',
		'cyberduck',
		'slack',
		'sourcetree',
		'mysqlworkbench',
		'istat-menus',
		'thunderbird',
		'openoffice',
		'netbeans'
	]: provider => 'brewcask', install_options => ['--appdir=/Applications'] }


	# Register APPLICATION_DEV=development environment variable to ensure Netbeans, etc pick it up
	# NOTE -> Doesn't seem to apply when application is loaded automatically at startup (reopen windows option)...
	file {
		"${home_dir}Library/LaunchAgents/APPLICATION_ENV.plist":
		 source => 'puppet:///modules/people/jbuncle/APPLICATION_ENV.plist'
	}
	exec {'load app env for netbeans':
    	command => "launchctl load -w ${home_dir}Library/LaunchAgents/APPLICATION_ENV.plist"
	}


	#SETUP/CHECKOUT NON-NAMES PROJECTS
	repository { "/Users/${::boxen_user}/Projects/phpcsmd":
	    source   => 'https://jbuncle@github.com/jbuncle/phpcsmd.git',
	    provider => 'git'
	}
	repository { "/Users/${::boxen_user}/Projects/puppet-php":
	    source   => 'https://github.com/namesco/puppet-php',
	    provider => 'git'
	}
	repository { "/Users/${::boxen_user}/Projects/puppet-gpgtools":
			source   => 'https://github.com/namesco/puppet-gpgtools',
			provider => 'git'
	}
	repository {
	  "/Users/${::boxen_user}/Projects/behat-boilerplate":
	    source   => 'https://github.com/jbuncle/behat-boilerplate.git',
	    provider => 'git'
	}
	repository {
		"/Users/${::boxen_user}/Projects/docker":
		  source   => 'https://jbuncle@stash.server.dev/scm/~jbuncle/docker.git',
			provider => 'git'
	}
	repository {
		"/Users/${::boxen_user}/Projects/composer":
		  source   => 'https://github.com/composer/composer.git',
			provider => 'git'
	}
	repository {
		"/Users/${::boxen_user}/Projects/sandbox":
		  source   => 'https://jbuncle@stash.server.dev/scm/~jbuncle/sandbox.git',
			provider => 'git'
	}
	repository {
		"/Users/${::boxen_user}/Projects/resources":
		  source   => 'https://jbuncle@stash.server.dev/scm/~jbuncle/resources.git',
			provider => 'git'
	}

	# SETUP SSH CONFIG
	# Checkout my dotfiles
	repository { "/Users/${::boxen_user}/src/dotfiles":
	    source   => 'https://jbuncle@stash.server.dev/scm/~jbuncle/dotfiles.git',
	    provider => 'git'
	}

	# Symlink the ssh config in place. Force because a file might already exist.
	file { "${home_dir}.ssh":
		ensure => link,
		force => true,
		target => "${home_dir}src/dotfiles",
		require => [
			Repository["/Users/${::boxen_user}/src/dotfiles"]
		]
	}
	exec { "chmod -R 700 /Users/${::boxen_user}/src/dotfiles":
		require => [
				File["${home_dir}.ssh"]
			]
	}

	exec { "chmod 600 /Users/${::boxen_user}/src/dotfiles/id_rsa":
		require => [
				File["${home_dir}.ssh"]
			]
	}

	$netbeans_config = "/Users/${::boxen_user}/Library/Application Support/NetBeans/8.2/config"
	# SETUP NetBeans Licence Header template
	file { "$netbeans_config/Templates":
		ensure => directory
	}
	file { "$netbeans_config/Templates/Licenses":
		ensure => directory
	}
	file { "$netbeans_config/Templates/Scripting":
		ensure => directory
	}
	file { 'Generate netbeans licence':
		path => "$netbeans_config/Templates/Licenses/license-default.txt",
		content => template("people/jbuncle/license-default.txt.erb")
	}
	file { 'Generate netbeans php class template':
		path => "$netbeans_config/Templates/Scripting/PHPClass.php",
		content => template("people/jbuncle/PHPClass.php.erb")
	}
	file { 'Generate netbeans properties':
		path => "/$netbeans_config/Templates/Properties/User.properties",
		content => template("people/jbuncle/User.properties.erb")
	}

	#include docker

	# Global composer

	# Install global Composer utilities
	# Update composer to latest version
	exec { 'clear composer':
		command => 'rm -rf ${home_dir}/.composer/composer.lock ${home_dir}/.composer/vendor'
	}
	exec { 'update composer to latest version':
		command => '/opt/boxen/phpenv/bin/composer selfupdate',
		cwd => $home_dir,
		require => Class['php::composer']
	}

	# Install global Composer utilities
	file { 'create global composer config':
		path => "${home_dir}/.composer/composer.json",
		ensure => present,
		content => template('people/jbuncle/composer.json.erb'),
		require => [
			Class['php::composer'],
			Exec['clear composer']
		]
	}
	exec { 'update global composer packages':
		command => "${::boxen_home}/phpenv/bin/composer global update",
		cwd => $home_dir,
		require => File['create global composer config'],
	}

	# Shell Shortcuts
	file { "${boxen::config::home}/env.d/shortcuts.sh":
		content => template('people/jbuncle/shortcuts.sh.erb'),
	}


	# OS X settings
	include osx::global::disable_autocorrect
	include osx::finder::unhide_library
	include osx::finder::show_hidden_files
	include osx::safari::enable_developer_mode
	include osx::dock::dim_hidden_apps
	include osx::dock::disable_dashboard
	include osx::finder::show_all_on_desktop
	include osx::finder::show_all_filename_extensions

	class { 'osx::dock::position':
		position => 'left'
	}
	class { 'osx::mouse::button_mode':
		mode => 2
	}
	class { 'osx::dock::icon_size':
		size => 36
	}
	osx::dock::hot_corner { 'Top Left':
		action => 'Start Screen Saver'
	}
	include osx::mouse::swipe_between_pages

	include projects::all
#	include openoffice

	$extensions = "/opt/boxen/config/php/${namesco::environment::php::php_version}/conf.d"

	file { 'copy jbuncle.ini':
		path => "${extensions}/jbuncle.ini",
		content => template('people/jbuncle/jbuncle.ini.erb'),
	}

}
