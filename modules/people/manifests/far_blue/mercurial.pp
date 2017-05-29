class people::far_blue::mercurial {

	$home = "/Users/${::boxen_user}"

	exec { 'Install mercurial':
		command => "pip install --upgrade mercurial"
	}

	exec { 'Install hg-git':
		command => "pip install --upgrade hg-git"
	}

	file { 'copy over hgrc':
		path => "${home}/.hgrc",
		source => "puppet:///modules/people/far_blue/profile/hgrc",
	}

}
