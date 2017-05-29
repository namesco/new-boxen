class people::far_blue::svn_settings {

	$home = "/Users/${::boxen_user}"

	file { 'opendiff launcher script':
		path => "${home}/.subversion/opendiffLauncher",
		source => "puppet:///modules/people/far_blue/svn_settings/opendiffLauncher",
		mode => "u+x",
	}

	file { 'subversion config':
		path => "${home}/.subversion/config",
		source => "puppet:///modules/people/far_blue/svn_settings/config",
	}
}
