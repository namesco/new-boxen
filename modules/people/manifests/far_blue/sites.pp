class people::far_blue::sites {

	$home = "/Users/${::boxen_user}"

	file { 'Projects symlink exists':
		path => "${home}/Projects",
		target => "/Volumes/Sites",
		ensure => link,
	}

	file { 'Sites symlink exists':
		path => "${home}/Sites",
		target => "${home}/Projects/Sites",
		ensure => link,
	}

}
