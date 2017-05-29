class people::far_blue::unwanted {

	exec { 'Remove unwanted ~/src folder':
		subscribe => File["${boxen::config::srcdir}/our-boxen"],
		command => 'rm -rf ~/src',
		onlyif => "[ -d \"/Users/${::boxen_user}/src\" ]",
	}

	exec { 'Remove unwanted standard namesco profile':
		subscribe => File["${boxen::config::home}/env.d/namesco.sh"],
		command => "rm -f /opt/boxen/env.d/namesco.sh",
		onlyif => "[ -f \"/opt/boxen/env.d/namesco.sh\" ]",
	}

	exec { 'Stop Apache':
		subscribe => Exec['apachectl restart'],
		command => 'apachectl stop',
		user => 'root',
	}

	exec { 'Remove global composer':
		subscribe => File["${boxen::config::home}/phpenv/bin/composer"],
		command => "rm -f /opt/boxen/phpenv/bin/composer",
		onlyif => "[ -f \"/opt/boxen/phpenv/bin/composer\" ]",
	}

}
