class people::far_blue::profile {
	file { 'copy over aliases':
		path => "/opt/boxen/env.d/aliases.sh",
		source => "puppet:///modules/people/far_blue/profile/aliases",
	}

	file { 'copy over personal env':
		path => "/opt/boxen/env.d/env.sh",
		source => "puppet:///modules/people/far_blue/profile/env",
	}
}
