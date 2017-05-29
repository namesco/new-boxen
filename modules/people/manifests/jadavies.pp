class people::jadavies {
	include dropbox
	include chrome
	include firefox
	include transmit
	include brewcask
	include alfred

	# install apps through brew-cask
	package {[
	'codekit',
	    'cornerstone',
	] : provider => 'brewcask', install_options => ['--appdir=/Applications'] }

	# Configure Apache and then restart it.
	file { '/etc/apache2/other/000-volumes-sites.conf':
		content => template('people/volumes-sites.conf.erb'),
		group => 'wheel',
		owner => 'root'
	}

	exec { "apachectl restart for volumes-sites":
		command => 'apachectl restart',
		user => 'root'
	}


}
