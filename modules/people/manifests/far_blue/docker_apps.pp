class people::far_blue::docker_apps {

	file { 'copy composer script into place':
		path => "/usr/local/bin/composer",
		source => "puppet:///modules/people/far_blue/docker_apps/composer",
		mode => "u+x",
	}
}