class namesco::apps::mac {

	include brewcask
	include ruby::global

	# If Subversion details are not cached, ensure they are in the env.
	exec { 'check for svn details':
		command => "svn ls http://svn.server.dev/svn/sharedlibraries --username '${::svn_user}' --password '${::svn_pass}'",
		creates => "/Users/${::boxen_user}/.subversion"
	}

	# ensure a gem is installed for a certain ruby version
	# note, you can't have duplicate resource names so you have to name like so
	$version = "2.2.2"
	ruby_gem { "bundler for ${version}":
	  gem          => 'bundler',
	  version      => '~> 1.9.0',
	  ruby_version => $version,
	}

	# Set the maximum number of open files to something very high so that we
	# don't run in to problems running SL unit tests
	file { '/Library/LaunchDaemons/com.apple.launchd.limit.plist':
		content => template('namesco/com.apple.launchd.limit.plist.erb'),
		group   => 'wheel',
		owner   => 'root'
	}

	file { "${boxen::config::home}/env.d/namesco.sh":
		content => template('namesco/namesco.sh.erb'),
	}

	if (hiera('projects::rabbitmq')) {
		# Install RabbitMQ (GUI + STOMP bindings enabled by default)
		include rabbitmq
	}
	# If you try and install this using the package provider, it doesn't work, don't know why...
	exec { 'brew install gettext':
		notify => Exec['brew link --force gettext'],
		creates => "${boxen::config::homebrewdir}/bin/msgfmt"
	}

	exec { 'brew link --force gettext':
		refreshonly => 'true',
	}

	include java

	# Install MySQL, users & tools, including creation of a phpuc user that the
	# 'phing db' process will use to populate the database for unit tests.
	include mysql
	exec { [
		"echo \"GRANT ALL ON *.* TO 'phpuc'@'localhost' IDENTIFIED BY 'phpuc' WITH GRANT OPTION;\" | mysql -u root",
		"echo \"GRANT ALL ON *.* TO 'namescouk'@'localhost' IDENTIFIED BY 'wir3df0rsound' WITH GRANT OPTION;\" | mysql -u root",
	]:
	}

	# Install other bits & bobs
	if (hiera('projects::virtualbox')) {
		class { 'virtualbox':
		  version => '4.3.26',
		  patch_level => '98988'
		}
	}
	package { [
		'csshx',
		'subversion'
	]:
	}
	package { [
		'gpgtools',
		'people-plus-content-ip',
		'screenhero',
		'sequel-pro',
		'skype',
	]: provider => 'brewcask', install_options => ['--appdir=/Applications'] }

	# Nasty hack to all installation of packages that require root.
	# Hopefully removed when this issue is resolved:
	# https://github.com/boxen/puppet-brewcask/issues/22#issuecomment-150398085
	sudoers { 'installer':
		users    => $::boxen_user,
		hosts    => 'ALL',
		commands => [
			'(ALL) SETENV:NOPASSWD: /usr/sbin/installer',
		],
		type     => 'user_spec',
	}

	package { 'polycom-realpresence-desktop':
		provider => 'brewcask',
		require  => [ Homebrew::Tap['caskroom/cask'], Sudoers['installer'] ],
	}

	# Get rbenv-vars in place.
	ruby::rbenv::plugin { 'rbenv-vars':
	  ensure => 'v1.2.0',
	  source  => 'sstephenson/rbenv-vars'
	}

	file { '/opt/boxen/rbenv/vars':
		ensure => 'file',
		content => 'APPLICATION_ENV=development',
		owner => $::boxen_user,
		mode => '0644',
	}

	#
	# Node
	#
	$nodeVersion = "4.5.0"
	nodejs::version { $nodeVersion: }
	class { 'nodejs::global': version => $nodeVersion }

	# bower
	npm_module { 'bower':
	  module => 'bower',
	  version => '~> 1.5.3',
	  node_version => $nodeVersion,
	}

	file { "${boxen::config::home}/env.d/bower.sh":
		content => template('namesco/bower.sh.erb'),
	}

	npm_module { 'gulp':
		module => 'gulp-cli',
		version => '~> 1.2.1',
		node_version => '*',
	}

}
