class people::far_blue::solarized {

	$home = "/Users/${::boxen_user}"
	$xcodeThemesDir = "${home}/Library/Developer/Xcode/UserData/FontAndColorThemes"

	file { 'copy terminal colors to /tmp':
		path => "/tmp/SolarizedDark.terminal",
		source => "puppet:///modules/people/far_blue/solarized/SolarizedDark.terminal",
	}

	exec { 'launch solarized.terminal to fix state':
		command => "open /tmp/SolarizedDark.terminal",
		require => File['copy terminal colors to /tmp'],
		creates => "${home}/.puppet-receipts/solarized-dark-terminal-installed",
	}

	file { 'create receipt of solarized.terminal process':
		path => "${home}/.puppet-receipts/solarized-dark-terminal-installed",
		content => generate('/bin/date', '+%Y%d%m_%H:%M:%S'),
		require => File['copy terminal colors to /tmp'],
	}


	exec { 'make xcode color themes dir':
		command => "mkdir -p $xcodeThemesDir",
		creates => $xcodeThemesDir,
	}

	file { 'copy xcode solarized light':
		path => "/Users/${::boxen_user}/Library/Developer/Xcode/UserData/FontAndColorThemes/SolarizedLight.dvtcolortheme",
		source => "puppet:///modules/people/far_blue/solarized/SolarizedLight.dvtcolortheme",
		require => Exec['make xcode color themes dir'],
	}

	file { 'copy xcode solarized dark':
		path => "/Users/${::boxen_user}/Library/Developer/Xcode/UserData/FontAndColorThemes/SolarizedDark.dvtcolortheme",
		source => "puppet:///modules/people/far_blue/solarized/SolarizedDark.dvtcolortheme",
		require => Exec['make xcode color themes dir'],
	}
}
