class namesco::environment::apache
{
	require namesco::environment::php

	# Install the mod_fcgid module for Apache
	include mod_fcgid

	# Configure Apache virtual hosts
	file { '/etc/apache2/other/namesco.conf':
		content => template('namesco/namesco.conf.erb'),
		group => 'wheel',
		owner => 'root',
		notify => Exec['apachectl restart'],
	}

	file { '/System/Library/LaunchDaemons/org.apache.httpd.plist':
		content => template('namesco/environment/apache/org.apache.httpd.plist.erb'),
		group => 'wheel',
		owner => 'root',
		notify => Exec['apachectl restart'],
	}

	# Configure Apache SSL
	file { '/etc/apache2/other/00-ssl.conf':
		content => template('namesco/00-ssl.conf.erb'),
		group => 'wheel',
		owner => 'root',
		notify => Exec['apachectl restart'],
	}

	# Configure Apache ssl.
	file { '/etc/apache2/server.crt':
		content => template('namesco/server.crt.erb'),
		group => 'wheel',
		owner => 'root',
		notify => Exec['apachectl restart'],
	}

	# Configure Apache ssl.
	file { '/etc/apache2/server.key':
		content => template('namesco/server.key.erb'),
		group => 'wheel',
		owner => 'root',
		notify => Exec['apachectl restart'],
	}

	# Restart apache
	exec { "apachectl restart":
		user => 'root',
		refreshonly => true,
	}
}
